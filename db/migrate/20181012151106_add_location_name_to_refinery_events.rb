class AddLocationNameToRefineryEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :refinery_events, :location_name, :string
  end
end
