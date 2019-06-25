module Refinery
  module Taggings
    class TaggingsController < ::ApplicationController

      before_action :find_all_taggings
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @tagging in the line below:
        present(@page)
      end

      def show
        @tagging = Tagging.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @tagging in the line below:
        present(@page)
      end

    protected

      def find_all_taggings
        @taggings = Tagging.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: "/taggings").first
      end

    end
  end
end
