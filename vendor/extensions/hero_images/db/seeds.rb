Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang

  Refinery::User.find_each do |user|
    user.plugins.where(name: 'refinerycms-hero_images').first_or_create!(
      position: (user.plugins.maximum(:position) || -1) +1
    )
  end if defined?(Refinery::User)

  Dir[Rails.root.join('vendor', 'extensions', 'hero_images', 'lib', 'import', '*')].each do |file|
    if file
      file_path = Rails.root.join(File.path(file).split('/').slice(6, 11).join('/'))
      image = ::Refinery::Image.create(image: file_path)
      hero_image = ::Refinery::HeroImages::HeroImage.create(title: image.image_name, description: image.image_name, image_id: image.id)
    else
      puts "ERROR: file error, not an image or not processable as an jpg image."
      puts "Please check app/vendor/extensions/hero_images/lib/import to confirm all files are of type: .jpg"
    end
  end
end
