Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang

  Refinery::User.find_each do |user|
    user.plugins.where(name: 'refinerycms-stories').first_or_create!(
      position: (user.plugins.maximum(:position) || -1) +1
    )
  end if defined?(Refinery::User)

  Refinery::Page.where(link_url: (url = "/stories")).first_or_create!(
    title: 'Stories',
    deletable: false,
    menu_match: "^#{url}(\/|\/.+?|)$"
  ) do |page|
    Refinery::Pages.default_parts.each_with_index do |part, index|
      page.parts.build title: part[:title], slug: part[:slug], body: nil, position: index
    end
  end if defined?(Refinery::Page)

  Refinery::Stories::Story.first_or_create!(title: 'Matt Zagaja | question1') do |story|
    story.submitter_name = 'Matt Zagaja'
    story.question = 'question1'
    story.response = 'Hyperloop!'
    story.display = true
  end if defined?(Refinery::Stories)
end
