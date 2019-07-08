module Refinery
  module Reports
    module Admin
      class ReportsController < ::Refinery::AdminController

        crudify :'refinery/reports/report'

        def create
          @report = Refinery::Reports::Report.create(report_params)
          if params[:tag]
            tags = params[:tag][:tag_ids].each do |tid|
              Refinery::Taggings::Tagging.create(report_id: @report.id, tag_id: tid.to_i)
            end
          end
          @report.save
          redirect_to reports_admin_reports_path and return
        end

        def update
          @report = Refinery::Reports::Report.find(params[:id])
          @report.taggings.each {|t| t.delete}
          tags = params[:tag][:tag_ids].each do |tid|
            new_tagging = Refinery::Taggings::Tagging.create(report_id: @report.id, tag_id: tid.to_i)
          end
          redirect_to taggings_admin_taggings_path and return
        end

        private

        # Only allow a trusted parameter "permit list" through.
        def report_params
          params.require(:report).permit(:title, :body, :date, :image_id, :link, :tag)
         end
      end
    end
  end
end
