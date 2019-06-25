FactoryBot.define do
  factory :tag, class: Refinery::Tags::Tag do
    sequence(:title, "a") { |n| "Test title #{n}" }
  end
end
