module Refinery
  module Tags
    class Tag < Refinery::Core::BaseModel
      self.table_name = 'refinery_tags'
      
      acts_as_indexed :fields => [:title]
      validates :title, :presence => true, :uniqueness => true
      validates :tag_type, :presence => true
      has_many :taggings, :class_name => '::Refinery::Taggings::Tagging', dependent: :destroy
      has_many :events, :class_name => '::Refinery::Events::Event', through: :taggings
      has_many :announcements, :class_name => '::Refinery::Announcements::Announcement', through: :taggings

      enum tag_type: {
        content_type: "content_type",
        topic_area: "topic_area"
      }

      def self.topic_areas
        self.all.select {|t| t.tag_type == 'topic_area'}
      end
      
      def self.content_types
        self.all.select {|t| t.tag_type == 'content_type'}
      end

    end
  end
end
