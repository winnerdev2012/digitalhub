
FactoryBot.define do
  factory :announcement, :class => Refinery::Announcements::Announcement do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

