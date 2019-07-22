class TaggingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :tag_id, :tag_title, :announcement_id, :event_id, :report_id, :tag_narrative

  belongs_to :tag, :class_name => '::Refinery::Tags::Tag'
  belongs_to :event, :class_name => '::Refinery::Events::Event', optional: true
  belongs_to :announcement, :class_name => '::Refinery::Announcements::Announcement', optional: true
  belongs_to :report, :class_name => '::Refinery::Reports::Report', optional: true

  attribute :sanitized_body do |record|
    Rails::Html::WhiteListSanitizer.new.sanitize(record.tag_title)
  end
end
