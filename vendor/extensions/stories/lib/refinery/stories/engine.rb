module Refinery
  module Stories
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Stories

      engine_name :refinery_stories

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "stories"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.stories_admin_stories_path }
          plugin.pathname = root

        end
      end

      initializer "refinery_stories.factories", after: "factory_bot.set_factory_paths" do
        FactoryBot.definition_file_paths << File.expand_path('../../../../spec/support/factories/refinery', __FILE__) if defined?(FactoryBot)
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Stories)
      end
    end
  end
end
