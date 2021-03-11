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
              coord = []

              coord[0] = building.address.lat
              coord[1] = building.address.lng

              address = "#{building.address.number_and_street}, #{building.address.city}, #{building.address.postal_code}, #{building.address.country}"
              
              info = "<h5 style='color: #CF3636; margin-top: 0;'>#{building.customer.company_name}</h5>"	
              info += "<h6 style='color: #0B64A0;'>#{address}</h6>"

              building.building_details.each do |building_detail|
                if building_detail.information_key == "Number of Floors"
                  info += "<b>Number of Floors:</b> #{building_detail.value}"
                end
              end

              info += "<br><b>Number of Batteries:</b> #{building.batteries.count}"

              amount_columns = 0
              amount_elevators = 0

              building.batteries.each do |battery|
                amount_columns += battery.columns.count      
                battery.columns.each do |column|
                  amount_elevators += column.elevators.count      
                end
              end
              
              info += "<br><b>Number of Columns:</b> #{amount_columns}"   
              info += "<br><b>Number of Elevators:</b> #{amount_elevators}"   
              info += "<br><b>Technical Contact:</b> #{building.full_name_of_the_technical_contact_for_the_building}"

              coord[2] = info
              @all_coords << coord
            end # end Building.all.each

            #######################################################################################################
            # This portion of code came with the action template by default
            # https://github.com/sferik/rails_admin/blob/master/lib/rails_admin/config/actions/dashboard.rb
            @history = @auditing_adapter && @auditing_adapter.latest(@action.auditing_versions_limit) || []
            if @action.statistics?
              @abstract_models = RailsAdmin::Config.visible_models(controller: self).collect(&:abstract_model)

              @most_recent_created = {}
              @count = {}
              @max = 0
              @abstract_models.each do |t|
                scope = @authorization_adapter && @authorization_adapter.query(:index, t)
                current_count = t.count({}, scope)
                @max = current_count > @max ? current_count : @max
                @count[t.model.name] = current_count
                next unless t.properties.detect { |c| c.name == :created_at }
                @most_recent_created[t.model.name] = t.model.last.try(:created_at)
              end
            end
            render @action.template_name, status: @status_code || :ok
            #######################################################################################################
          
          end# end proc
        end # end :controller

      end 
    end
  end
end