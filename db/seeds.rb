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
  topic_areas = ["transportation", "housing", "environment", "health", "economic development", "arts & culture", "dynamic government"]
  content_types = ["publications", "news", "events", "calls to action", "datasets"]
  topic_area_narratives = {
    "transportation":
    "Accessible, frequent, and fast public transit gets people to their destinations without contributing to traffic and is an important factor to lowering carbon emissions. Connected, well-maintained, and extensive trails, bike lanes, and sidewalks encourage active transportation, health, and recreation. Making roadways safe, comfortable, and accessible for users of all ages, abilities, income, and travel modes leads to healthier and stronger communities.",
    "housing":
    "We all need a home. Young professionals, families with kids, empty nesters, seniors, workers, people with disabilities, people struggling to make ends meet – all of us need somewhere to live.",
    "environment":
    "MAPC’s Environment Department provides technical assistance and policy guidance to municipalities on issues ranging from climate preparedness and vulnerability assessments to natural hazard mitigation to sustainable water management.",
    "health":
      "At MAPC, we integrate public health perspectives into our work: from planning projects to data collection and analysis to policy development. MAPC is on the forefront of linking health and planning to help make our communities safe, healthy, and equitable.",
    "economic development":
    "The benefits of economic growth are many, and Metropolitan Boston needs them.The challenge is to stimulate and manage economic growth to promote not only prosperity, but also livability:equity, health, sustainability, safety, and a municipality’s unique sense of place and community.Then, it’s not just economic growth: it’s economic development.",
    "arts & culture": "MAPC's Arts and Culture Department delivers technical assistance in emerging practice areas including cultural planning, creative placemaking, creative community development, arts and cultural data collection and analysis, and cultural policy.",
    "dynamic government":
      "MAPC's charge is to use planning to help cities and towns prepare various plans and programs to solve a range of land use and zoning issues. MAPC partners with municipalities in our region to improve Metro Boston’s livability, its prosperity, safety, health, equity, and distinctive character.Listed below are various land use planning projects that MAPC frequently undertakes with communities, using a variety of funding sources(e.g., municipal funds, MAPC Technical Assistance funds, state grants)."
  }

  topic_areas.each do |topic_area|
    ::Refinery::Tags::Tag.create(
      title: topic_area,
      tag_type: "topic_area",
      narrative: topic_area_narratives[topic_area.to_sym])
  end

  content_types.each do |content_type|
    ::Refinery::Tags::Tag.create(title: content_type, tag_type: "content_type")
  end
end

load_default_tag_types
