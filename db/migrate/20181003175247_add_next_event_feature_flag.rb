class AddNextEventFeatureFlag < ActiveRecord::Migration[5.2]
  def self.up
    Flipper.disable(:next_event)
  end

  def self.down
    Flipper.remove(:next_event)
  end
end
