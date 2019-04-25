class AnnouncementSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :link, :position
  has_one :image

  attribute :sanitized_body do |record|
    Rails::Html::WhiteListSanitizer.new.sanitize(record.body)
  end
end
