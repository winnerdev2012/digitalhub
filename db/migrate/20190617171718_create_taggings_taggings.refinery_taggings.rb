# This migration comes from refinery_taggings (originally 1)
class CreateTaggingsTaggings < ActiveRecord::Migration[5.2]

  def up
    create_table :refinery_taggings do |t|
      t.integer :tag_id
      t.integer :event_id
      t.integer :announcement_id
      t.integer :position

      t.timestamps
    end


  end


  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-taggings"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/taggings/taggings"})
    end

    drop_table :refinery_taggings

  end
end
