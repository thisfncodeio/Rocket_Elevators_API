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

     #===================================================================================================
     # CREATING THE TICKETS FOR THE ZENDESK API
     #===================================================================================================
        
        client = ZendeskAPI::Client.new do |config|
            config.url = ENV['ZENDESK_URL']
            config.username = ENV['ZENDESK_USERNAME']
            config.token = ENV['ZENDESK_TOKEN']
        end
        
        ZendeskAPI::Ticket.create!(client, 
            :subject => "#{@lead.full_name_of_contact} from #{@lead.company_name}", 
            :comment => { 
                :value => "The contact #{@lead.full_name_of_contact} 
                    from company #{@lead.company_name} 
                    can be reached at email  #{@lead.email} 
                    and at phone number #{@lead.phone}. 
                    #{@lead.department_in_charge_of_elevators} has a project named #{@lead.project_name} which would require contribution from Rocket Elevators.
                    \n\n
                    Project Description
                    #{@lead.project_description}\n\n
                    Attached Message: #{@lead.message}"
            }, 
            :requester => { 
                "name": @lead.full_name_of_contact, 
                "email": @lead.email 
            },
            :priority => "normal",
            :type => "question"
            )

    end    # End for def Create
     #===================================================================================================
     # DEFINING @lead = Lead.new(lead_params) BELOW:
     #===================================================================================================
     
     
     # Only allow a list of trusted parameters through.
    def lead_params
       
        params.required(:leads).permit!
        #sendToDropbox = DropboxApiController.new
        #sendToDropbox.send(:callbackAuth)

        
    end
    # using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

@lead = Lead.new(lead_params)
email = params["email"]
from = Email.new(email: 'jay-t-dot-2k@gmail.com')
to = Email.new(email: email)
subject = 'Sending with SendGrid is Fun'
content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = Mail.new(from, subject, to, content)
personalization = Personalization.new
personalization.add_to(Email.new(email: 'jay-t-dot-2k@hotmail.com'))
mail.add_personalization(personalization)
mail.template_id = 'd-8f34084713894cdfa0ddfb0625bb19fb'
sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers

end