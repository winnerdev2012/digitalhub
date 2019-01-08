require "google/cloud/speech"
class TranscriptionWorker
  include Sidekiq::Worker

  def perform(story_id)
    story = Story.find(story_id)
    speech = Google::Cloud::Speech.new(credentials: Rails.application.credentials.gcs)
    config = { encoding:          :LINEAR16,
             language_code:     "en-US"   }
    audio  = { uri: "gs://maps-digital-hub/#{story.audio.key}" }

    operation = speech.long_running_recognize config, audio
    operation.wait_until_done!
    raise operation.results.message if operation.error?

    recognized_text = ''
    for i in 0..(operation.response['results'].length - 1) do
      recognized_text += operation.response['results'][i]['alternatives'][0]['transcript']
    end
    story.update(response: recognized_text)
  end
end
