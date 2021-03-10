
# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

class LeadsController < ApplicationController
# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby


class LeadsController < ApplicationController
    require 'zendesk_api'

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
        
        if @lead.save!
            redirect_back fallback_location: root_path, notice: "Your Request was successfully created and sent!"

        end 
        #email = :email 
        #full_name = :full_name_of_contact 
        #project_name = :project_name

        from = Email.new(email: 'jaytdot2k@gmail.com')
        to = Email.new(email: @lead.email)
        subject = 'Sending with SendGrid is Fun'
        content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
        #mail = Mail.new(from, subject, to, content)
        mail = SendGrid::Mail.new(from,subject,to,content)
        
        personalization = Personalization.new
       # personalization.add_dynamic_template_data({
         #   "FullName" => @lead.full_name_of_contact ,
          #  "ProjectName" => @lead.project_name
          #})
        personalization.add_to(Email.new(email: @lead.email))
        personalization.add_dynamic_template_data("FullName" => @lead.full_name_of_contact());
        personalization.add_dynamic_template_data("ProjectName"=> @lead.project_name());
        
        mail.add_personalization(personalization)
        mail.template_id = 'd-ab22bc2be7e44ad9bdbc5531c9b59f21'

        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

        response = sg.client.mail._('send').post(request_body: mail.to_json)
        puts response.status_code
        puts response.body
        puts response.headers 
    end    

        end


     #===================================================================================================
     # CREATING THE TICKETS FOR THE ZENDESK API
     #===================================================================================================
        
        client = ZendeskAPI::Client.new do |config|
            config.url = ENV['ZENDESK_URL']
            config.username = ENV['ZENDESK_USERNAME']
            config.token = ENV['ZENDESK_TOKEN']
        end

        
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
