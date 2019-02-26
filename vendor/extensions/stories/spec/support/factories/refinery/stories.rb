FactoryBot.define do
  factory :story, :class => Refinery::Stories::Story do
    sequence(:submitter_name) { |n| "refinery#{n}" }
    question { 'question1' }
    display { true }
    response { 'Our ideas about the future!' }

    trait :with_video do
      video { fixture_file_upload(Refinery::Stories.root.join('spec', 'support', 'assets', 'test-video.mp4'), 'video/mp4') }
    end
  end
end

