
class ReportSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :body, :date, :position, :tags
  has_one :image, :class_name => '::Refinery::Image'
  has_many :taggings, :class_name => '::Refinery::Taggings::Tagging'
  has_many :tags, :class_name => '::Refinery::Tags::Tag', through: :taggings

  attribute :sanitized_body do |record|
    Rails::Html::WhiteListSanitizer.new.sanitize(record.body)
  end
end
