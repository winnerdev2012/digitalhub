namespace :db do
  desc 'create 3 invalid database objects, run validator'
  task create_invalid_data: :environment do
    puts 'Creating 3 invalid database objects ... '
    ValidationService.create_invalid_data
    puts 'Validating all objects in database ... '
    data_exceptions = ValidationService.call
    ValidationService.results_console_output
  end
end
