class SeedHeroImages < ActiveRecord::Migration[5.2]
  def up
    Dir[Rails.root.join('vendor', 'extensions', 'hero_images', 'lib', 'import', '*')].each do |file|
      if file
        file_path = Rails.root.join(File.path(file))
        image = ::Refinery::Image.create(image: file_path)
        ::Refinery::HeroImages::HeroImage.create(title: image.image_name, description: image.image_name, image_id: image.id)
      else
        puts "ERROR: file error, not an image or not processable as an jpg image."
        puts "Please check app/vendor/extensions/hero_images/lib/import to confirm all files are of type: .jpg"
      end
    end
  end

  def down
  end
end
