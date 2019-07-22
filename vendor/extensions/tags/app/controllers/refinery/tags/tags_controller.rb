module Refinery
  module Tags
    class TagsController < ::ApplicationController

      before_action :find_all_tags
      before_action :find_page

      def index
        tags_json = @tags.map {|t| TagSerializer.new(t).serializable_hash}
        respond_to do |f|
          f.html { present(@page) }
          f.json { render json: tags_json}
        end
      end

      def show
        @tag = Tag.find(params[:id])
        tag_json = TagSerializer.new(@tag).serializable_hash
        respond_to do |f|
          f.html { present(@page) }
          f.json { render json: tag_json}
        end
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
