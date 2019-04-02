require "google/cloud/speech"
class TranscriptionWorker
  include Sidekiq::Worker

  def perform(story_id)
    story = Refinery::Stories::Story.find(story_id)
    path = "#{Dir.tmpdir}/#{story.audio.filename}"
    File.open(path, 'wb') do |file|
      file.write(story.audio.download)
    end
    sample_rate_hertz = `ffprobe -show_entries stream=sample_rate -hide_banner -of default=noprint_wrappers=1:nokey=1 #{path}  2> /dev/null`
    speech = Google::Cloud::Speech.new(credentials: Rails.application.credentials.gcs)
    config = { encoding: :LINEAR16,
               language_code: "en-US",
               sample_rate_hertz: sample_rate_hertz.strip.to_i }
    audio  = { uri: "gs://maps-digital-hub/#{story.audio.key}" }

    operation = speech.long_running_recognize(config, audio)
    operation.wait_until_done!
    raise operation.results.message if operation.error?
    Rails.logger.info '=Google Cloud Response='
    Rails.logger.info operation
    recognized_text = ''
    for i in 0..(operation.response['results'].length - 1) do
      recognized_text += operation.response['results'][i]['alternatives'][0]['transcript']
    end
    story.update(response: recognized_text)
  end
end
