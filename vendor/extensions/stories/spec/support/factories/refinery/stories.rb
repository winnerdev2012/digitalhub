
FactoryBot.define do
  factory :story, :class => Refinery::Stories::Story do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

