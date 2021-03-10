
 class DropboxApiController < ApplicationController
    def callbackAuth
    client = DropboxApi::Client.new(ENV["DROPBOX_TOKEN"])
    client_key = ENV["DROPBOX_KEY"]
    client_secret = ENV["DROPBOX_SECRET"]

    path= "/" + $company_name.to_s + ""
    file= IO.read File.join(Rails.root, 'public', $attachment.to_s)
    
    file_path = path + "/" + $attachment.to_s.partition('/uploads/leadAttachement/').last.partition('/').last
    
    DropboxApi::Authenticator.new(client_key, client_secret)

    begin 
        client.get_metadata path
    rescue DropboxApi::Errors::NotFoundErrror
       client.create_folder path
       client.upload file_path,  file
       ActiveRecord::Base.connection.exec_query("UPDATE leads SET attacheemnt= NULL WHERE company_name = '#($company_name.to_s)'")
    else 
       client.upload file_path,  file
       ActiveRecord::Base.connection.exec_query("UPDATE leads SET attachement= NULL WHERE company_name = '#($company_name.to_s)'")
    end 
    redirect_to '/#contact'
end  

    
end 