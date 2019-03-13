module Refinery
  module Announcements
    class AnnouncementsController < ::ApplicationController

      def index
        announcements = ::Refinery::Announcements::Announcement.all
        all_announcements = announcements.map { |announcement| AnnouncementSerializer.new(announcement, { :include => [:image] }).serializable_hash }
        render json: all_announcements
      end

    end
  end
end
