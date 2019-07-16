class TagSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :tag_type, :position, :taggings, :events, :announcements, :reports, :narrative

  has_many :taggings, :class_name => '::Refinery::Taggings::Tagging', dependent: :destroy
  has_many :events, :class_name => '::Refinery::Events::Event', through: :taggings
  has_many :announcements, :class_name => '::Refinery::Announcements::Announcement', through: :taggings
  has_many :reports, :class_name => '::Refinery::Reports::Report', through: :taggings

  attribute :sanitized_body do |record|
    Rails::Html::WhiteListSanitizer.new.sanitize(record.title)
  end
end
