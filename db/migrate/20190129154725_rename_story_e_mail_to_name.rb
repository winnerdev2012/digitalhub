class RenameStoryEMailToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :refinery_stories, :email, :name
  end
end
