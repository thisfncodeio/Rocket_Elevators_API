# require 'open_weather'
require 'geocoder'

module RailsAdmin
  module Config
    module Actions
      class Map < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :root? do
          true
        end
        
        register_instance_option :breadcrumb_parent do
          nil
        end
        
        register_instance_option :auditing_versions_limit do
          100
        end

        register_instance_option :route_fragment do
          'map.html.erb'
        end

        register_instance_option :link_icon do
          'icon-map-marker'
        end

        register_instance_option :statistics? do
          false
        end


        register_instance_option :controller do
          proc do

            @all_coords = []
            Building.all.each do |building|
              coord = {}

              address = [
                building.address.number_and_street, 
                building.address.city, 
                building.address.postal_code, 
                building.address.country].compact.join(', ')

              if Geocoder.search(address).length > 0
                coordinates = Geocoder.search(address)
                
                if coordinates.first.coordinates.length > 0
                  
                  coord["lat"] =  coordinates.first.coordinates[0]
                  coord["lng"] =  coordinates.first.coordinates[1]
                  @all_coords << coord
                end
              end

            end

            # @buildings = Building.all
            # @hash = Gmaps4rails.build_markers(@buildings) do |building, marker|
            #   address = [building.address.number_and_street, building.address.city, building.address.postal_code, building.address.country].compact.join(', ')

              
            #   if Geocoder.search(address).length > 0
            #     coordinates = Geocoder.search(address)
                
            #     if coordinates.first.coordinates.length > 0
            #       puts "ADDRESS ==> " + address
            #       puts "COORD LENGTH ==> #{coordinates.first.coordinates.length.to_s}"
            #       puts "COORDS ==>"
            #       puts coordinates.first.coordinates
                  
            #       marker.lat coordinates.first.coordinates[0]
            #       marker.lng coordinates.first.coordinates[1]
            #     end
            #   end
            # end

          #   @greeting = "Hello World"
          #   @datas = []
          #   Building.all.each do |building|
          #     data = {}
          #     address = [building.address.number_and_street, building.address.city, building.address.postal_code, building.address.country].compact.join(', ')
              
          #     if Geocoder.search(address).length > 0
          #       get_coordinates = Geocoder.search(address)
          #       pp get_coordinates

          #       data[:lat] = get_coordinates.first.coordinates[0]
          #       data[:lng] = get_coordinates.first.coordinates[1]
          #     end

              
          #     $amount_columns = 0
          #     $amount_elevators = 0

          #     options = { units: "metric", APPID: ENV['GOOGLE_MAPS_API_KEY'] }
          #     weather = OpenWeather::Current.geocode(data[:lat], data[:lng] , options)

          #     temp = weather.dig("main", "temp")
          #     feels_like = weather.dig("main", "feels_like")


          #     comment = "<h4><FONT color='#920001'>#{building.customer.company_name}</FONT></h4>"	
          #     comment += "<h6><FONT color='#0B64A0'>#{address}</FONT></h6>"		
          #     comment += "<b>Number of Batteries:</b> #{building.batteries.count}"
              
          #     building.batteries.each do |battery|
          #       $amount_columns += battery.columns.count      
          #       battery.columns.each do |column|
          #         $amount_elevators += column.elevators.count      
          #       end
          #     end
          #     comment += "<br><b>Number of Columns:</b> #{$amount_columns}"   
          #     comment += "<br><b>Number of Elevators:</b> #{$amount_elevators}"   
          #     comment += "<br><b>Technical contact:</b> #{building.full_name_of_the_technical_contact_for_the_building}"
          #     comment += "<br><b>Current weather:</b> #{temp}°C, feels like #{feels_like}°C"

              
          #     data[:infowindow] = comment
          #     @datas.append(data)
          #   end
          #   @history = @auditing_adapter && @auditing_adapter.latest(@action.auditing_versions_limit) || []
          #   if @action.statistics?
          #     @abstract_models = RailsAdmin::Config.visible_models(controller: self).collect(&:abstract_model)

          #     @most_recent_created = {}
          #     @count = {}
          #     @max = 0
          #     @abstract_models.each do |t|
          #       scope = @authorization_adapter && @authorization_adapter.query(:index, t)
          #       current_count = t.count({}, scope)
          #       @max = current_count > @max ? current_count : @max
          #       @count[t.model.name] = current_count
          #       next unless t.properties.detect { |c| c.name == :created_at }
          #       @most_recent_created[t.model.name] = t.model.last.try(:created_at)
          #     end
          #   end
          #   render @action.template_name, status: @status_code || :ok
          end
        end


      end
    end
  end
end