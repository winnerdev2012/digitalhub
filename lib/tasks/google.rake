require "google/cloud/speech"
require 'pry-byebug'
namespace :google do
  task transcribe: :environment do
    speech = Google::Cloud::Speech.new(credentials: Rails.application.credentials.gcs)
    config = { encoding:          :LINEAR16,
             sample_rate_hertz: 48000,
             language_code:     "en-US"   }
    # audio  = { uri: "gs://maps-digital-hub/#{story.audio.key}" }
    audio  = { uri: "gs://maps-digital-hub/8RVd8ftmY4qd7Fn4DshAu9Bp" }

    operation = speech.long_running_recognize config, audio
    operation.wait_until_done!
    raise operation.results.message if operation.error?
    results = operation.response.results
    alternatives = results.first.alternatives
    Story.last.update(response: alternatives.first.transcript)
  end

  task transcode: :environment do
    story = Story.find(30)
    binary = story.video.download
    path = "#{Dir.tmpdir}/#{story.video.filename.to_s}"
    File.open(path, 'wb') do |file|
       file.write(story.video.download)
    end
    system "ffmpeg -i #{path} #{Dir.tmpdir}/#{story.video.key}.wav"
    story.audio.attach(io: File.open("#{Dir.tmpdir}/#{story.video.key}.wav"),
                       filename: story.video.filename.to_s.match('.*(?=\.)')[0] + '.wav',
                       content_type: 'audio/x-wav')
  end
end
