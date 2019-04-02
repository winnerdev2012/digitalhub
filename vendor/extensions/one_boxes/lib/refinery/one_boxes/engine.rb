module Refinery
  module OneBoxes
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::OneBoxes

      engine_name :refinery_one_boxes

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "one_boxes"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.one_boxes_admin_one_boxes_path }
          plugin.pathname = root

        end
      end

      initializer "refinery_one_boxes.factories", after: "factory_bot.set_factory_paths" do
        FactoryBot.definition_file_paths << File.expand_path('../../../../spec/support/factories/refinery', __FILE__) if defined?(FactoryBot)
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::OneBoxes)
      end
    end
  end
end
