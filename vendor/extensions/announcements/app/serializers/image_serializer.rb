class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :url, :alt, :image_name, :image_width, :image_height, :carousel_thumbnail_url

  attribute :carousel_thumbnail_url do |record|
    record.thumbnail({geometry: :carousel}).url
  end
end
