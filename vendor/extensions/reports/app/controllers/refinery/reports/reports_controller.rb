module Refinery
  module Reports
    class ReportsController < ::ApplicationController

      before_action :find_all_reports
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @report in the line below:
        present(@page)
      end

      def show
        @report = Report.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @report in the line below:
        present(@page)
      end

    protected

      def find_all_reports
        @reports = Report.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: "/reports").first
      end

    end
  end
end
