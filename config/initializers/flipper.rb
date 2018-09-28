require 'flipper'
require 'flipper/adapters/memory'

Flipper.configure do |config|
  config.default { Flipper.new(Flipper::Adapters::Memory.new) }
end

Flipper.enable(:search)
