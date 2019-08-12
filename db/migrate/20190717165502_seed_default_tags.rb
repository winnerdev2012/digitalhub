class SeedDefaultTags < ActiveRecord::Migration[5.2]
  def up
    content_types = ["publications", "news", "events", "calls to action", "datasets"]
    topic_areas = ["transportation", "housing", "environment", "health", "economic development", "arts & culture", "dynamic government"]
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

    topic_areas.each do |topic_area_title|
      ::Refinery::Tags::Tag.create(
        title: topic_area_title,
        tag_type: "topic_area",
        narrative: topic_area_narratives[topic_area_title.to_sym])
    end

    content_types.each do |content_type_title|
      ::Refinery::Tags::Tag.create(title: content_type_title, tag_type: "content_type")
    end
  end

  def down
    ::Refinery::Tags::Tag.all {|t| t.destroy!}
  end
end
