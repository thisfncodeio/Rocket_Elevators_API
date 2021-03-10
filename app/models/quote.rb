class Quote < ApplicationRecord
#    after_save :create_quote_ticket

#   def create_quote_ticket
#       client = ZendeskAPI::Client.new do |config|
#           config.url = ENV['ZENDESK_URL']
#           config.username = ENV['ZENDESK_USERNAME']
#           config.token = ENV['ZENDESK_TOKEN']
#       end
#       ZendeskAPI::Ticket.create!(client, 
#           :subject => "#{self.company_name}", 
#           :comment => { 
#               :value => "The company name #{self.company_name} 
#                   can be reached at email #{self.email}. 
#                   Building type selected is #{self.building_type} with product line #{self.product_line}. 
#                   Number of suggested elevator is #{self.sub_total} and total price is #{self.total}. \n
#                   For More Information, refers to Quote ##{self.id}."
#           }, 
#           :requester => { 
#               "name": self.company_name, 
#               "email": self.email
#             },
#           :priority => "normal",
#           :type => "task"
#           )
#   end
end
