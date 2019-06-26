module Refinery
  module Reports
    module Admin
      class ReportsController < ::Refinery::AdminController

        crudify :'refinery/reports/report'

        private

        # Only allow a trusted parameter "permit list" through.
        def report_params
          params.require(:report).permit(:title, :body, :date, :image_id)
        end
      end
    end
  end
end
