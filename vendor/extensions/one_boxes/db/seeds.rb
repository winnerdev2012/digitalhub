Refinery::I18n.frontend_locales.each do |lang|
  I18n.locale = lang

  Refinery::User.find_each do |user|
    user.plugins.where(name: 'refinerycms-one_boxes').first_or_create!(
      position: (user.plugins.maximum(:position) || -1) +1
    )
  end if defined?(Refinery::User)

end
