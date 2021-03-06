
FactoryBot.define do
  factory :event, :class => Refinery::Events::Event do
    sequence(:title) { |n| "refinery#{n}" }
    image
  end
end
