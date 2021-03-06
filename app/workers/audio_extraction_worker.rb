class AudioExtractionWorker
  include Sidekiq::Worker

  def perform(story_id)
    story = Refinery::Stories::Story.find(story_id)
    path = "#{Dir.tmpdir}/#{story.video.filename}"
    File.open(path, 'wb') do |file|
      file.write(story.video.download)
    end
    system "ffmpeg -i #{path} #{Dir.tmpdir}/#{story.video.key}.wav > log/#{Rails.env}.log 2>&1"
    story.audio.attach(io: File.open("#{Dir.tmpdir}/#{story.video.key}.wav"),
                       filename: story.video.filename.to_s.match('.*(?=\.)')[0] + '.wav',
                       content_type: 'audio/x-wav')
    TranscriptionWorker.perform_async(story_id)
  end
end
