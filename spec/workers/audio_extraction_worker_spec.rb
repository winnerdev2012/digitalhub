require 'rails_helper'
RSpec.describe AudioExtractionWorker, type: :worker do
  it "extracts audio and orders a transcription" do
    story = create(:story, :with_video)
    story.reload

    worker = AudioExtractionWorker.new
    worker.perform(story.id)

    story.reload
    expect(TranscriptionWorker.jobs.size).to eq(1)
    expect(story.audio.attached?).to be_truthy
    Sidekiq::Worker.clear_all
  end
end
