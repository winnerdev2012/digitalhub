require 'csv'

class SeedReports < ActiveRecord::Migration[5.2]
  def up
    csv_text = File.read(Rails.root.join('vendor', 'extensions', 'reports', 'lib', 'import', 'report_seed.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each do |row|
      tag1_id = ::Refinery::Tags::Tag.find_by(title: row['tag1']).id
      tag2_id = ::Refinery::Tags::Tag.find_by(title: row['tag2']).id

      file_path = Rails.root.join(Rails.root.join('vendor', 'extensions', 'reports', 'lib', 'import', row['image_file_name']))
      image = ::Refinery::Image.create(image: file_path)
      new_report = ::Refinery::Reports::Report.create( title: row['title'],
                                           body: row['body'],
                                           date: row['date'],
                                           image_id: image.id)

      ::Refinery::Taggings::Tagging.create(tag_id: tag1_id, report_id: new_report.id)
      ::Refinery::Taggings::Tagging.create(tag_id: tag2_id, report_id: new_report.id)
    end
  end

  def down
    csv_text = File.read(Rails.root.join('vendor', 'extensions', 'reports', 'lib', 'import', 'report_seed.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each do |row|
      ::Refinery::Reports::Report.find_by(title: row['title']).destroy!
    end
  end
end
