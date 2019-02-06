
FactoryBot.define do
  factory :story, :class => Refinery::Stories::Story do
    sequence(:submitter_name) { |n| "refinery#{n}" }
  end
end

