require 'csv'

class SeedOneBoxes < ActiveRecord::Migration[5.2]
  def up
    csv_text = File.read(Rails.root.join('vendor', 'extensions', 'one_boxes', 'lib', 'import', 'one_box_seed.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each do |row|
      file_path = Rails.root.join(Rails.root.join('vendor', 'extensions', 'one_boxes', 'lib', 'import', row['image_file_name']))
      image = ::Refinery::Image.create(image: file_path)
      ::Refinery::OneBoxes::OneBox.create( title: row['title'],
                                           visible: row['visible'] == 'TRUE',
                                           triangle_overlay: row['triangle_overlay'] == 'TRUE',
                                           image_id: image.id,
                                           link: row['link'])
    end
  end

  def down
    csv_text = File.read(Rails.root.join('vendor', 'extensions', 'one_boxes', 'lib', 'import', 'one_box_seed.csv'))
    csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
    csv.each do |row|
      ::Refinery::OneBoxes::OneBox.find_by(title: row['title']).destroy!
    end
  end
end
