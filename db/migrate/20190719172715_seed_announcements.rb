require 'csv'

class SeedAnnouncements < ActiveRecord::Migration[5.2]
  def up
    csv_text = File.read(Rails.root.join('vendor', 'extensions', 'announcements', 'lib', 'import', 'announcement_seed.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each do |row|
      tag1_id = ::Refinery::Tags::Tag.find_by(title: row['tag1']).id
      tag2_id = ::Refinery::Tags::Tag.find_by(title: row['tag2']).id

      file_path = Rails.root.join(Rails.root.join('vendor', 'extensions', 'announcements', 'lib', 'import', row['image_file_name']))
      image = ::Refinery::Image.create(image: file_path)
      new_announcement = ::Refinery::Announcements::Announcement.create(title: row[0],
        body: row['body'],
        link: row['link'],
        image_id: image.id)

      ::Refinery::Taggings::Tagging.create(tag_id: tag1_id, announcement_id: new_announcement.id)
      ::Refinery::Taggings::Tagging.create(tag_id: tag2_id, announcement_id: new_announcement.id)
    end
  end

  def down
    csv_text = File.read(Rails.root.join('vendor', 'extensions', 'announcements', 'lib', 'import', 'announcement_seed.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each do |row|
      ::Refinery::Announcements::Announcement.find_by(title: row['title']).destroy
    end
  end
end
