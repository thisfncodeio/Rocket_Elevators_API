class Customer < ApplicationRecord
    belongs_to :user
    belongs_to :address
    has_many :buildings 
    has_one :lead

    after_create :migrate_to_dropbox # call migrate_to_dropbox after creating a customer
    after_update :migrate_to_dropbox  # call migrate_to_dropbox after updating a customer

    
    # The funstion below migrates attachement to dropbox: it follows the following steps:
    # 1. Connect to the Rocket Elevators DropBox account
    # 2. Create a directory in DropBox on behalf of the client if the client does not already exist
    # 3. Extract the file stored in the binary field of the MySQL database
    # 4. Copy this file to the client DropBox directory
    # 5. If the document is successfully downloaded to Dropbox, the controller deletes the content of the binary field from the database to avoid duplication
    def migrate_to_dropbox   
        # puts self.id
        dropbox_client = DropboxApi::Client.new
 
        # puts self.email_of_company_contact    
        Lead.where(email: self.email_of_company_contact).each do |lead| # for each lead has this email_of_company_contact  
          unless lead.attachment.nil?   #check if the lead has an attachment  
            path = "/" + self.full_name_of_company_contact   #create a variable path that has the full name of the company contact
            begin           
                dropbox_client.create_folder path   #Create a directory in DropBox on behalf of the customer if the customer does not already exist

            rescue DropboxApi::Errors::FolderConflictError => err
              puts "The folder is not created since it already exists. just carry on with uploading the file"
            end  
            begin
              dropbox_client.upload(path + "/" + lead.file_name, lead.attachment)   # Copy this file to the client DropBox directory
            rescue DropboxApi::Errors::FileConflictError => err
              puts "File already exists in the folder.do not upload anything."
            end  
  
            lead.attachment = nil; #delete  the attachement from the lead table to avoid duplication
            lead.save!
          end
      end 
    end



    
end
