module Refinery
  module Events
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Events

      engine_name :refinery_events

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "events"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.events_admin_events_path }
          plugin.pathname = root

        end
      end

      initializer "refinery_events.factories", after: "factory_bot.set_factory_paths" do
        FactoryBot.definition_file_paths << File.expand_path('../../../../spec/support/factories/refinery', __FILE__) if defined?(FactoryBot)
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Events)
      end
    end
  end
end
