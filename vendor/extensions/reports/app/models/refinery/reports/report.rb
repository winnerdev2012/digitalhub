module Refinery
  module Reports
    class Report < Refinery::Core::BaseModel
      self.table_name = 'refinery_reports'

      validates :title, :presence => true, :uniqueness => true
      belongs_to :image, :class_name => '::Refinery::Image'
      has_many :taggings, :class_name => '::Refinery::Taggings::Tagging'
      has_many :tags, :class_name => '::Refinery::Tags::Tag', through: :taggings

      def self.tagged_with(title)
        Refinery::Tags::Tag.find_by_title!(title).reports
      end
      
      def self.tag_counts
        Refinery::Tags::Tag.select("tags.*, count(taggings.tag_id) as count").
          joins(:taggings).group("taggings.tag_id")
      end
        
      def tag_list
        tags.map(&:title).join(", ")
      end

      def tag_list=(titles)
        self.tags = titles.split(",").map do |t|
          Refinery::Tags::Tag.where(title: t.strip).first_or_create!
        end
      end
    end
  end
end
