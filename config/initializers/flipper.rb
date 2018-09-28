require 'flipper'

Flipper.configure do |config|
  config.default { Flipper.new(Flipper::Adapters::ActiveRecord.new) }
end

Flipper.enable(:search)
