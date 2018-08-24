# encoding: utf-8

Refinery::I18n.configure do |config|
  config.default_locale = :en

  config.current_locale = :en

  config.default_frontend_locale = :en

  config.frontend_locales = [:en, :pt, :es, :"zh-CN", :fr]

  config.locales = {:en=>"English", :pt=>"Português", :es=>"Español", :"zh-CN"=>"简体中文", :fr=>"Français" }
end
