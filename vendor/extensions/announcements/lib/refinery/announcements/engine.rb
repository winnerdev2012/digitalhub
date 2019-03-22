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

      initializer "refinery_announcements.factories", after: "factory_bot.set_factory_paths" do
        FactoryBot.definition_file_paths << File.expand_path('../../../../spec/support/factories/refinery', __FILE__) if defined?(FactoryBot)
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Announcements)
      end
    end
  end
end
