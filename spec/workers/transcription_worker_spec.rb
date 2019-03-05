require 'rails_helper'
require "google/gax/operation"
RSpec.describe TranscriptionWorker, type: :worker do
  it "gets a transcription of the audio from Google" do
    story = create(:story, :with_audio)
    story.reload

    operation = double('Google::Gax::Operation')
    allow(operation).to receive(:wait_until_done!) { true }
    allow(operation).to receive(:error?) { false }
    allow(operation).to receive(:response) do
      {"results" =>
          [
            {"alternatives" =>
              [
                {"transcript" => "the text in transcript"}
              ]
            }
          ]
        }
    end

    speech = double('Google::Cloud::Speech')
    allow(speech).to receive(:long_running_recognize).with(hash_including(:encoding, :language_code), hash_including(:uri)) do
      operation
    end

    allow(Google::Cloud::Speech).to receive(:new) { speech }
    allow(Google::Gax::Operation).to receive(:new) { operation }

    worker = TranscriptionWorker.new
    worker.perform(story.id)

    story.reload
    expect(story.response.present?).to be_truthy
    Sidekiq::Worker.clear_all
  end
end
