module Refinery
  module Taggings
    class Tagging < Refinery::Core::BaseModel
      self.table_name = 'refinery_taggings'

      validates :tagged_item_title, presence: true
      validate :has_tagged_item?
      belongs_to :tag, :class_name => '::Refinery::Tags::Tag'
      belongs_to :event, :class_name => '::Refinery::Events::Event', optional: true
      belongs_to :announcement, :class_name => '::Refinery::Announcements::Announcement', optional: true
      belongs_to :report, :class_name => '::Refinery::Reports::Report', optional: true

      scope :topic_area_taggings, -> { where(tag_type: 'topic_area') }

      def self.total_pages
        self.count / 12
      end

      def self.current_page
        1
      end

      def content_type
        if event
          "events"
        elsif announcement
          "news"
        elsif report
          "publications"
        else
        end
      end

      def tag_type
        self.tag.tag_type
      end

      def tag_title
        self.tag.title.downcase
      end

      def tag_narrative
        self.tag.narrative
      end

      def tagged_item_title
        if announcement
          announcement.title.downcase.lstrip
        elsif event
          event.title.downcase.lstrip
        elsif report
          report.title.downcase.lstrip
        else
          "associated Active Record instance NOT found"
        end
      end

      def has_tagged_item?
        self.announcement || self.event || self.report ? true : errors.add(:has_tagged_item?, "tagging must have tagged model instance")
      end

      def self.filter_taggings(filters)
        # these are intentionally harded coded because the names evolve whenever Integrated Comms has a meeting
        content_type_filter = ["news", "publications", "events"]
        topic_area_filter = ["transportation", "housing", "environment", "health", "economic development", "arts & culture", "dynamic government"]
        result = []

        # update content_type_filter
        if filters[0] != "everything"
         content_type_filter = filters[0]
        end

        # update topic_area_filter
        if filters[1] != "all topic areas"
          topic_area_filter = filters[1]
        end

        # filter for taggings with selected topic_area(s) and content_type tagging(s)
        Refinery::Taggings::Tagging.all.each do |t|
          if topic_area_filter.include?(t.tag_title) && content_type_filter.include?(t.content_type)
            result.push(t)
          end
        end

        # filter out duplicates based on tagged_item_title
        result.uniq {|r| r.tagged_item_title}
      end
    end
  end
end
