FactoryBot.define do
  factory :story, :class => Refinery::Stories::Story do
    sequence(:submitter_name) { |n| "refinery#{n}" }
    question { 'question1' }
    display { true }
    response { 'Our ideas about the future!' }

    trait :with_video do
      video { fixture_file_upload(Refinery::Stories.root.join('spec', 'support', 'assets', 'test-video.mp4'), 'video/mp4') }
    end

    trait :with_audio do
      audio { fixture_file_upload(Refinery::Stories.root.join('spec', 'support', 'assets', 'test-audio.wav'), 'audio/wav') }
    end
  end
end
