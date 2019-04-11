require 'csv'

Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang

  Refinery::User.find_each do |user|
    user.plugins.where(name: 'refinerycms-one_boxes').first_or_create!(
      position: (user.plugins.maximum(:position) || -1) +1
    )
  end if defined?(Refinery::User)
end


I18n.locale = :en
csv_text = File.read(Rails.root.join('vendor', 'extensions', 'one_boxes', 'lib', 'import', 'one_box_seed.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
csv.each do |row|
  file_path = Rails.root.join(Rails.root.join('vendor', 'extensions', 'one_boxes', 'lib', 'import', row['image_file_name']))
  image = ::Refinery::Image.create(image: file_path)
  box = ::Refinery::OneBoxes::OneBox.create( title: row['title'],
                                             visible: row['visible'] == 'TRUE',
                                             triangle_overlay: row['triangle_overlay'] == 'TRUE',
                                             image_id: image.id,
                                             link: row['link'])
end
