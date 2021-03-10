# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

class LeadsController < ApplicationController
        
    # POST /quotes or /quotes.json
    def create
        @lead = Lead.new(lead_params)
        
        #===================================================================================================
        # DECLARING VARIABLES  
        #===================================================================================================
        attachment = params["attachment"]
        #@lead.file_name = attachment
        
        #===================================================================================================
        # SAVER  
        #===================================================================================================
        @lead.save

        #===================================================================================================
        # PRINTS PARAMS INTO TERMINAL WINDOW
        #===================================================================================================
        puts "===========START================"
        puts params
        puts "=============END================"

        #===================================================================================================
        # FORM SUBMISSION & FILE ATTACHMENT LOGIC (converts into binary code, submission alert, redirecting, rendering, errors) 
        #===================================================================================================
        if attachment != nil
            @lead.attachment = attachment.read
            @lead.file_name = attachment.original_filename
        end

        
        

        # @lead = Lead.new(lead_params)
        # email = params["leads[email]"]
        from = Email.new(email: 'aakibu.dev@gmail.com')
        to = Email.new(email: @lead.email)
        subject = 'Sending with SendGrid is Fun'
        content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
        # mail = Mail.new(from, subject, to, content)
        mail = SendGrid::Mail.new(from, subject, to, content)
        personalization = Personalization.new
        personalization.add_to(Email.new(email: 'jay-t-dot-2k@hotmail.com'))
        mail.add_personalization(personalization)
        # mail.template_id = 'd-8f34084713894cdfa0ddfb0625bb19fb'
        mail.template_id = 'd-0cf0e1cad5414f24a813b9ff8c2072c7'
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: mail.to_json)
        puts response.status_code
        puts response.body
        puts response.headers
        
        if @lead.save!
            redirect_back fallback_location: root_path, notice: "Your Request was successfully created and sent!"
        end    
    end

    #===================================================================================================
    # DEFINING @lead = Lead.new(lead_params) BELOW:
    #===================================================================================================
    # Only allow a list of trusted parameters through.
    def lead_params
        params.required(:leads).permit!
    end  

end