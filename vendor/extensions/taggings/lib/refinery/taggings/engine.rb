module Refinery
  module Taggings
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Taggings

      engine_name :refinery_taggings

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "taggings"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.taggings_admin_taggings_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Taggings)
      end
    end
  end
end
