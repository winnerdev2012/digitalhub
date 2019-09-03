namespace :db do
  desc 'call .valid? on each database object, return results'
  task validate: :environment do
    puts 'Validating all objects in database ... '
    ValidationService.call
    ValidationService.results_console_output
  end
end
