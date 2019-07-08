Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang

  Refinery::User.find_each do |user|
    user.plugins.where(name: 'refinerycms-tags').first_or_create!(
      position: (user.plugins.maximum(:position) || -1) +1
    )
  end if defined?(Refinery::User)

  Refinery::Page.where(link_url: (url = "/tags")).first_or_create!(
    title: 'Tags',
    deletable: false,
    menu_match: "^#{url}(\/|\/.+?|)$"
  ) do |page|
    Refinery::Pages.default_parts.each_with_index do |part, index|
      page.parts.build title: part[:title], slug: part[:slug], body: nil, position: index
    end
  end if defined?(Refinery::Page)
end

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
