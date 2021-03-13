class Elevator < ApplicationRecord
  enum elevator_status: [:Active, :Inactive, :Intervention]
  before_update :slack_notifier
  before_update :twilio_notifier
  belongs_to :column
  
  def twilio_notifier
    if self.status_changed?
      account_sid = "#{ENV["ACCOUNT_SID"]}"
      auth_token = "#{ENV["AUTH_TOKEN"]}"
      @client = Twilio::REST::Client.new account_sid, auth_token

      if self.status_changed?
        @client.api.account.messages.create(
          from: "+17276108703",
          to: "5145037764", #For demonstration
          # to: self.column.battery.building.technical_contact_phone_for_the_building,
          body: "Elevator #{self.id} with Serial Number #{self.serial_number} require maintenance.")
      end
    end   
  end
  
  def slack_notifier
    if self.status_changed?
    require 'date'
    current_time = DateTime.now.strftime("%d-%m-%Y %H:%M")
    notifier = Slack::Notifier.new ENV["Slack_API"]
    notifier.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{self.status_was} to #{self.status} at #{current_time}."
    end
  end
  
end