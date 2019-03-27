
FactoryBot.define do
  factory :hero_image, :class => Refinery::HeroImages::HeroImage do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

