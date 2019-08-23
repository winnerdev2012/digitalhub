class ValidationService < ApplicationRecord
  @@results = {announcements: [], events: [], hero_images: [], one_boxes: [], reports: [], stories: [], tags: [], taggings: []}

  def self.call
    @@results = {announcements: [], events: [], hero_images: [], one_boxes: [], reports: [], stories: [], tags: [], taggings: [], test_exceptions: []}
    self.announcements
    self.events
    self.hero_images
    self.one_boxes
    self.reports
    self.stories
    self.tags
    self.taggings
    self.results
  end

  def self.results
    @@results
  end

  def self.results_console_output
    @@results.keys.each do |key|
      @@results[key].each do |item|
        if @@results[key].count > 1
          puts "Error:"
          puts "#{item[:type]} id:#{item[:id]} has errors: #{item[:errors].each {|err| err}} \n \n"
        else
          puts item
          puts '----------------------'
        end
      end
    end
  end

  def self.create_invalid_data
    event = Refinery::Events::Event.new(title: 'test event exception', image: nil)
    event.save(validate: false)

    report = Refinery::Reports::Report.new(title: 'test report exception', image: nil, date: nil)
    report.save(validate: false)

    announcement = Refinery::Announcements::Announcement.new(title: 'test announcement exception', image: nil, published_date: nil)
    announcement.save(validate: false)

    self.call
  end

  def self.announcements
    ::Refinery::Announcements::Announcement.all.each do |announcement|
      !announcement.valid? ? @@results[:announcements].push({id: announcement.id, type: 'Announcement', edit_url: "/hubadmin/announcements/#{announcement.id}/edit", errors: announcement.errors.full_messages}) : nil
    end
    @@results[:announcements].length == 0 ? @@results[:announcements].push('all announcements valid') : nil
  end

  def self.events
    ::Refinery::Events::Event.all.each do |event|
      !event.valid? ? @@results[:events].push({id: event.id, type: 'Event', edit_url: "/hubadmin/events/#{event.id}/edit", errors: event.errors.full_messages}) : nil
    end
    @@results[:events].length == 0 ? @@results[:events].push('all events valid') : nil
  end

  def self.hero_images
    ::Refinery::HeroImages::HeroImage.all.each do |hero_image|
      !hero_image.valid? ? @@results[:hero_images].push({id: hero_image.id, type: 'Hero Image', edit_url: "/hubadmin/hero_images/#{hero_image.id}/edit", errors: hero_image.errors.full_messages}) : nil
    end
    @@results[:hero_images].length == 0 ? @@results[:hero_images].push('all hero_images valid') : nil
  end

  def self.one_boxes
    ::Refinery::OneBoxes::OneBox.all.each do |one_box|
      !one_box.valid? ? @@results[:one_boxes].push({id: one_box.id, type: 'One Box', edit_url: "/hubadmin/one_boxes/#{one_box.id}/edit", errors: one_box.errors.full_messages}) : nil
    end
    @@results[:one_boxes].length == 0 ? @@results[:one_boxes].push('all one_boxes valid') : nil
  end

  def self.reports
    ::Refinery::Reports::Report.all.each do |report|
      !report.valid? ? @@results[:reports].push({id: report.id, type: 'Report', edit_url: "/hubadmin/reports/#{report.id}/edit", errors: report.errors.full_messages}) : nil
    end
    @@results[:reports].length == 0 ? @@results[:reports].push('all reports valid') : nil
  end

  def self.stories
    ::Refinery::Stories::Story.all.each do |story|
      !story.valid? ? @@results[:stories].push({id: story.id, type: 'Story', edit_url: "/hubadmin/stories/#{story.id}/edit", errors: story.errors.full_messages}) : nil
    end
    @@results[:stories].length == 0 ? @@results[:stories].push('all stories valid') : nil
  end

  def self.tags
    ::Refinery::Tags::Tag.all.each do |tag|
      !tag.valid? ? @@results[:tags].push({id: tag.id, type: 'Tag', edit_url: "/hubadmin/tags/#{tag.id}/edit", errors: tag.errors.full_messages}) : nil
    end
    @@results[:tags].length == 0 ? @@results[:tags].push('all tags valid') : nil
  end

  def self.taggings
    ::Refinery::Taggings::Tagging.all.each do |tagging|
      !tagging.valid? ? @@results[:taggings].push({id: tagging.id, type: 'Tagging', edit_url: "/hubadmin/tagging/#{tagging.id}/edit", errors: tagging.errors.full_messages}) : nil
    end
    @@results[:taggings].length == 0 ? @@results[:taggings].push('all taggings valid') : nil
  end
end
