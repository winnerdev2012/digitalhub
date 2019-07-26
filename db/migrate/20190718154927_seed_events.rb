require 'csv'

class SeedEvents < ActiveRecord::Migration[5.2]
  def up
    csv_text = File.read(Rails.root.join('vendor', 'extensions', 'events', 'lib', 'import', 'event_seed.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each do |row|
      tag1_id = ::Refinery::Tags::Tag.find_by(title: row[12]).id
      tag2_id = ::Refinery::Tags::Tag.find_by(title: row[13]).id

      file_path = Rails.root.join(Rails.root.join('vendor', 'extensions', 'reports', 'lib', 'import', row['image_file_name']))
      image = ::Refinery::Image.create(image: file_path)
      new_event = ::Refinery::Events::Event.create(title: row['title'],
        description: row['description'],
        start: Date.parse(row['start']),
        end: Date.parse(row['end']),
        event_type: row['event_type'],
        address: row['address'],
        city: row['city'],
        state: row['state'],
        zipcode: row['zipcode'],
        registration_link: row['registration_link'],
        location_name: row['location_name'],
        image_id: image.id)

        ::Refinery::Taggings::Tagging.create(tag_id: tag1_id, event_id: new_event.id)
        ::Refinery::Taggings::Tagging.create(tag_id: tag2_id, event_id: new_event.id)
    end
  end

  def down
    csv_text = File.read(Rails.root.join('vendor', 'extensions', 'events', 'lib', 'import', 'event_seed.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each do |row|
      ::Refinery::Events::Event.find_by(title: row['title']).destroy
    end
  end
end
