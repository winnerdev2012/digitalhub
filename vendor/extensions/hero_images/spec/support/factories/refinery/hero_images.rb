FactoryBot.define do
  factory :hero_image, :class => ::Refinery::HeroImages::HeroImage do
    sequence(:title) { |n| "HeroImage#{n}" }
    description { "This describes the hero image." }
    image
  end
end