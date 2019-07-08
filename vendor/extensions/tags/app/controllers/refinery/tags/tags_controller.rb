module Refinery
  module Tags
    class TagsController < ::ApplicationController

      before_action :find_all_tags
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @tag in the line below:
        present(@page)
      end

      def show
        @tag = Tag.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @tag in the line below:
        present(@page)
      end

    protected

      def find_all_tags
        @tags = Tag.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: "/tags").first
      end

    end
  end
end
