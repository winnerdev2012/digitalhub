Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang

  Refinery::User.find_each do |user|
    user.plugins.where(name: 'refinerycms-events').first_or_create!(
      position: (user.plugins.maximum(:position) || -1) +1
    )
  end if defined?(Refinery::User)

  Refinery::Page.where(link_url: (url = "/events")).first_or_create!(
    title: 'Events',
    deletable: false,
    menu_match: "^#{url}(\/|\/.+?|)$"
  ) do |page|
    Refinery::Pages.default_parts.each_with_index do |part, index|
      page.parts.build title: part[:title], slug: part[:slug], body: nil, position: index
    end
  end if defined?(Refinery::Page)

  Refinery::Events::Event.first_or_create!(title: 'North Suburban Planning Committee (NSPC) Breakfast & Lunch') do |event|
    event.start = DateTime.now + 15.days
    event.end =  DateTime.now + 15.days + 1.hour
    event.event_type = 'Meeting'
    event.address = '380 Main Street'
    event.city = 'Stoneham'
    event.state = 'MA'
    event.zipcode = '02180'
    event.location_name = 'Town Hall'
  end if defined?(Refinery::Events)
end
