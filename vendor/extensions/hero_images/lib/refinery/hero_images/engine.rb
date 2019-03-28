module Refinery
  module HeroImages
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::HeroImages

      engine_name :refinery_hero_images

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "hero_images"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.hero_images_admin_hero_images_path }
          plugin.pathname = root
          
        end
      end

      initializer "refinery_hero_images.factories", after: "factory_bot.set_factory_paths" do
        FactoryBot.definition_file_paths << File.expand_path('../../../../spec/support/factories/refinery', __FILE__) if defined?(FactoryBot)
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::HeroImages)
      end
    end
  end
end
