# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed

# Added by Refinery CMS Search engine
Refinery::Search::Engine.load_seed

# Added by Refinery CMS Events extension
Refinery::Events::Engine.load_seed

Flipper.disable(:search)
Flipper.disable(:action_buttons)
Flipper.disable(:next_event)

# Added by Refinery CMS Stories extension
Refinery::Stories::Engine.load_seed

# Added by Refinery CMS Announcements extension
Refinery::Announcements::Engine.load_seed

# Added by Refinery CMS HeroImages extension
Refinery::HeroImages::Engine.load_seed

# Added by Refinery CMS OneBoxes extension
Refinery::OneBoxes::Engine.load_seed

# Added by Refinery CMS WeighInPrompts extension
Refinery::WeighInPrompts::Engine.load_seed

# Added by Refinery CMS Reports extension
Refinery::Reports::Engine.load_seed

# Added by Refinery CMS Tags extension
Refinery::Tags::Engine.load_seed

# Added by Refinery CMS Taggings extension
Refinery::Taggings::Engine.load_seed

def load_default_tag_types
  topic_areas = ["Housing", "Climate", "Transportation", "Land Use", "Development", "Equity"]
  content_types = ["Event", "Report", "Project", "Video", "Action", "Data"]
  
  topic_areas.each do |topic_area_title|
    ::Refinery::Tags::Tag.create(title: topic_area_title, tag_type: "topic_area")
  end
  
  content_types.each do |content_type_title|
    ::Refinery::Tags::Tag.create(title: content_type_title, tag_type: "content_type")
  end
end

load_default_tag_types
