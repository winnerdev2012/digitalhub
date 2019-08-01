source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 5.2'
gem "puma"
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'
gem 'pg'
gem "font-awesome-rails"
gem 'mini_magick'
gem 'webpacker', '~> 3.5'
gem 'google-cloud-speech'
gem 'sidekiq'
gem 'google-cloud-storage'
gem 'local_time'
gem 'fast_jsonapi'
gem "autoprefixer-rails"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'momentjs-rails', '~> 2.17', '>= 2.17.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'dotenv-rails'
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'terminal-notifier-guard'
  gem "capistrano", "~> 3.10", require: false
  gem "capistrano-rails", "~> 1.3", require: false
  gem "capistrano-bundler"
  gem "capistrano-passenger"
  gem "capistrano-rvm"
  gem "pry-rescue"
  gem "pry-stack_explorer"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  gem 'capybara-screenshot'
  gem 'browserstack-local'
  gem 'parallel'
  gem 'axe-matchers'
end

# Flipper for feature flags
gem 'flipper'
gem 'flipper-active_record'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Refinery CMS
gem 'refinerycms', '~> 4.0', :git => 'https://github.com/refinery/refinerycms.git'

# Optionally, specify additional Refinery CMS Extensions here:
gem 'refinerycms-acts-as-indexed', ['~> 3.0', '>= 3.0.0']
gem 'refinerycms-wymeditor', ['~> 2.0', '>= 2.0.0']
gem 'refinerycms-authentication-devise', '~> 2.0.0', :git => 'https://github.com/refinery/refinerycms-authentication-devise.git'
#  gem 'refinerycms-blog', ['~> 4.0', '>= 4.0.0']
#  gem 'refinerycms-inquiries', ['~> 4.0', '>= 4.0.0']
gem 'refinerycms-search', github: 'refinery/refinerycms-search', branch: 'master'
# gem 'refinerycms-page-images', ['~> 4.0', '>= 4.0.0']
gem 'refinerycms-i18n'

gem 'refinerycms-events', path: 'vendor/extensions'

gem 'aws-sdk-translate'

gem 'refinerycms-stories', path: 'vendor/extensions'

gem 'refinerycms-announcements', path: 'vendor/extensions'

gem 'refinerycms-hero_images', path: 'vendor/extensions'
gem 'refinerycms-one_boxes', path: 'vendor/extensions'

gem 'refinerycms-weigh_in_prompts', path: 'vendor/extensions'

gem 'refinerycms-reports', path: 'vendor/extensions'
gem 'refinerycms-tags', path: 'vendor/extensions'
gem 'refinerycms-taggings', path: 'vendor/extensions'
