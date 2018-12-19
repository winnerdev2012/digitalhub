class AddResponseTextToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :response, :text
  end
end
