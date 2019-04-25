module Refinery
  module WeighInPrompts
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::WeighInPrompts

      engine_name :refinery_weigh_in_prompts

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "weigh_in_prompts"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.weigh_in_prompts_admin_weigh_in_prompts_path }
          plugin.pathname = root

        end
      end

      initializer "refinery_weigh_in_prompts.factories", after: "factory_bot.set_factory_paths" do
        FactoryBot.definition_file_paths << File.expand_path('../../../../spec/support/factories/refinery', __FILE__) if defined?(FactoryBot)
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::WeighInPrompts)
      end
    end
  end
end
