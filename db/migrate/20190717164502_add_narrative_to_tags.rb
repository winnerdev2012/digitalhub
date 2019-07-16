class AddNarrativeToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :refinery_tags, :narrative, :text
  end
end
