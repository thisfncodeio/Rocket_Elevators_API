
require 'net/http'
require 'uri'
require 'json'

class WatsonController < ApplicationController

    def watson 


      uri = URI.parse("https://gateway-wdc.watsonplatform.net/text-to-speech/api/v1/synthesize?voice=en-US_AllisonVoice")
      request = Net::HTTP::Post.new(uri)
      request.basic_auth("apikey", ENV['watsonAPI'])
      request.content_type = "application/json"
      request["Accept"] = "audio/wav"
      request.body = JSON.dump({
        "text" => "Hi #{current_user.first_name}, there are currently #{Elevator.all.size} elevators deployed in the #{Building.all.size} buildings of your #{Customer.all.size} customers and #{Battery.all.size} batteries are deployed across #{Address.all.distinct.count('city')} cities. Currently, #{Elevator.all.where(status: 'Intervention').count} elevators are not in running status and are being serviced. You have #{Quote.all.size} quotes awaiting processing and you have #{Lead.all.size} leads in your contact requests. " 
      })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

       response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
       
      end

      send_data response.body
  
  
  end
end
