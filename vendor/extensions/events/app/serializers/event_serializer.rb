class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :start, :end, :image_id, :event_type, :description, :address, :city, :state, :zipcode, :registration_link, :position, :tags
  has_one :image, :class_name => '::Refinery::Image'
  has_many :taggings, :class_name => '::Refinery::Taggings::Tagging'
  has_many :tags, :class_name => '::Refinery::Tags::Tag', through: :taggings

  attribute :sanitized_body do |record|
    Rails::Html::WhiteListSanitizer.new.sanitize(record.description)
  end
end
