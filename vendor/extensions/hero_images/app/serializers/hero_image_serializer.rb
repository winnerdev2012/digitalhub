class HeroImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :position
  has_one :image
end
