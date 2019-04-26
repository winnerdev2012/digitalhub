# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-weigh_in_prompts'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Weigh In Prompts extension for Refinery CMS'
  s.date              = '2019-04-25'
  s.summary           = 'Weigh In Prompts extension for Refinery CMS'
  s.authors           = ["Matthew Zagaja"]
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 4.0.2'
  s.add_dependency             'acts_as_indexed',     '~> 0.8.0'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 4.0.2'
end
