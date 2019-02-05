class AddTitleToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :refinery_stories, :title, :string
    rename_column :refinery_stories, :name, :submitter_name
  end
end
