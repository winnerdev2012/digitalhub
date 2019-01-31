class RemoveOldStories < ActiveRecord::Migration[5.2]
  def up
    drop_table :stories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
