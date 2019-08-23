
FactoryBot.define do
  factory :report, :class => Refinery::Reports::Report do
    sequence(:title) { |n| "refinery#{n}" }
    image
  end
end

