FactoryBot.define do
  factory :report, class: Refinery::Reports::Report do
    sequence(:title, "a") { |n| "Test title #{n}" }
    image
  end
end
