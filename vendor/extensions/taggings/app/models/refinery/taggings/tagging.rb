module Refinery
  module Taggings
    class Tagging < Refinery::Core::BaseModel
      self.table_name = 'refinery_taggings'

      validates :tagged_item_title, presence: true
      belongs_to :tag, :class_name => '::Refinery::Tags::Tag'
      belongs_to :event, :class_name => '::Refinery::Events::Event', optional: true
      belongs_to :announcement, :class_name => '::Refinery::Announcements::Announcement', optional: true
      belongs_to :report, :class_name => '::Refinery::Reports::Report', optional: true

      def self.total_pages
        self.count / 12
      end

      def self.current_page
        1
      end

      def self.topic_areas
        self.all.select {|t| t.tag.tag_type == 'topic_area'}
      end
      
      def self.content_types
        self.all.select {|t| t.tag.tag_type == 'content_type'}
      end

      def extension_class_name
        if event 
          "event"
        elsif announcement
          "announcement"
        elsif report
          "report"
        else
        end
      end

      def tag_title
        return self.tag.title.downcase
      end

      def tagged_item_title
        if event
          event.title.downcase.lstrip
        elsif announcement
          announcement.title.downcase.lstrip
        elsif report
          report.title.downcase.lstrip
        else
        end
      end

      def self.sort_by_item_title
        self.all.sort_by(&:tagged_item_title)
      end

    end
  end
end
