
FactoryBot.define do
  factory :tag, :class => Refinery::Tags::Tag do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

