module Refinery
  module Announcements
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Announcements

      engine_name :refinery_announcements

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "announcements"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.announcements_admin_announcements_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Announcements)
      end
    end
  end
end
