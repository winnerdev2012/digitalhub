class AddDescriptionToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :refinery_events, :description, :text
  end
end
