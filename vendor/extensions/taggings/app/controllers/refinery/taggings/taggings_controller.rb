module Refinery
  module Taggings
    class TaggingsController < ::ApplicationController

      before_action :find_all_taggings
      before_action :find_page

      def index
        filters = [params[:content_type] || "everything", params[:topic_area] || "all topic areas"]
        topic_area_narrative = Refinery::Tags::Tag.all.find_by(title: filters[1]).narrative if filters[1] != "all topic areas"
        filtered_taggings = Refinery::Taggings::Tagging.filter_taggings(filters)
        filtered_taggings_sorted = filtered_taggings.sort { |a, b| b.sort_date <=> a.sort_date }.reverse
        filtered_taggings_json = filtered_taggings_sorted.map {|t| TaggingSerializer.new(t).serializable_hash }

        respond_to do |f|
          f.html { present(@page) }
          f.json { render json: {
            taggings: filtered_taggings_json,
            topic_area_narrative: topic_area_narrative,
            next_three_events: Refinery::Events::Event.next_three_events
            }}
        end
      end

      def show
        @tagging = ::Refinery::Taggings::Tagging.find(params[:id])
        tagging_json = TaggingSerializer.new(@tagging).serializable_hash

        respond_to do |f|
          f.html { present(@page) }
          f.json { render json: tagging_json}
        end
      end

      def data_validation
        @data_exceptions = ValidationService.call
        render json: @data_exceptions.to_json
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
