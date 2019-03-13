class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :url, :alt, :image_name, :image_width, :image_height
end
