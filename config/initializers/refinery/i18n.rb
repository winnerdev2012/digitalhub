# encoding: utf-8

Refinery::I18n.configure do |config|
  config.default_locale = :en
  config.current_locale = :en
  config.default_frontend_locale = :en
  config.frontend_locales = [:en, :pt, :es, :"zh-CN", :fr]
  config.locales = {:en=>"English", :pt=>"Português", :es=>"Español", :"zh-CN"=>"简体中文", :fr=>"Français" }
  # Fallback language configuration so titles always have something
  Mobility.configure do |config|
    config.default_options[:fallbacks] = { :'pt' => 'en', :'es' => 'en', :'zh-CN' => 'en', :'fr' => 'en' }
  end
end
