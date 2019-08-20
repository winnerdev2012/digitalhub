module Refinery
  module Announcements
    class AnnouncementsController < ::ApplicationController
      before_action :find_all_announcements
      before_action :find_page

      def index
        announcements = ::Refinery::Announcements::Announcement.all
        all_announcements = announcements.map { |announcement| AnnouncementSerializer.new(announcement, { :include => [:image] }).serializable_hash }
        render json: all_announcements
      end

      def show
        @announcement = ::Refinery::Announcements::Announcement.find(params[:id])
        announcement_json = AnnouncementSerializer.new(@announcement, { :include => [:image] }).serializable_hash
        @tags = @announcement.tags.map {|t| t.tag_type == 'topic_area' ? t.title : nil }.compact.join(', ')

        respond_to do |f|
          f.html { render '/refinery/announcements/show'}
          f.json { render json: announcement_json}
        end
      end

    protected

      def find_all_announcements
        @announcements = Announcement.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: "/announcements").first
      end

    end
  end
end
