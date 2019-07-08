module Refinery
  module Tags
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Tags

      engine_name :refinery_tags

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "tags"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.tags_admin_tags_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Tags)
      end
    end
  end
end
