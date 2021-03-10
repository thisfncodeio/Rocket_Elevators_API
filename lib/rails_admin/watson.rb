module RailsAdmin
  module Config
    module Actions
      class Watson < RailsAdmin::Config::Actions::Base
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
          'watson.html.erb'
        end

        register_instance_option :link_icon do
          'icon-play-circle'
        end

        register_instance_option :statistics? do
          false
        end

      end
    end
  end
end