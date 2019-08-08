module Refinery
  module Reports
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Reports

      engine_name :refinery_reports

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "reports"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.reports_admin_reports_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Reports)
      end
    end
  end
end
