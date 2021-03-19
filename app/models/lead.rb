class Lead < ApplicationRecord
   # belongs_to :customer
   # after_save :create_lead_ticket

   # def create_lead_ticket
   #     client = ZendeskAPI::Client.new do |config|
   #         config.url = ENV['ZENDESK_URL']
   #         config.username = ENV['ZENDESK_USERNAME']
   #         config.token = ENV['ZENDESK_TOKEN']
   #     end
       
   #     ZendeskAPI::Ticket.create!(client, 
   #         :subject => "#{self.full_name_of_contact} from #{self.company_name}", 
   #         :comment => { 
   #             :value => "The contact #{self.full_name_of_contact} 
   #                 from company #{self.company_name} 
   #                 can be reached at email  #{self.email} 
   #                 and at phone number #{self.phone}. 
   #                 #{self.department_in_charge_of_elevators} has a project named #{self.project_name} which would require contribution from Rocket Elevators.
   #                 \n\n
   #                 Project Description
   #                 #{self.project_description}\n\n
   #                 Attached Message: #{self.message}"
   #         }, 
   #         :requester => { 
   #             "name": self.full_name_of_contact, 
   #             "email": self.email 
   #         },
   #         :priority => "normal",
   #         :type => "question"
   #         )
   # end
end
