class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :url, :alt, :image_name, :image_width, :image_height, :carousel_thumbnail_url, :carousel_thumbnail_2x_url, :hero_image_thumbnail_url, :hero_image_thumbnail_2x_url

  attribute :carousel_thumbnail_url do |record|
    record.thumbnail({geometry: :carousel}).url
  end

  attribute :carousel_thumbnail_2x_url do |record|
    record.thumbnail({geometry: :carousel2x}).url
  end

  attribute :hero_image_thumbnail_url do |record|
    record.thumbnail({geometry: :hero_image}).url
  end

  attribute :hero_image_thumbnail_2x_url do |record|
    record.thumbnail({geometry: :hero_image2x}).url
  end
end
