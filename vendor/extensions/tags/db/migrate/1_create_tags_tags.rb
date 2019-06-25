class CreateTagsTags < ActiveRecord::Migration[5.2]

  def up
    create_table :refinery_tags do |t|
      t.string :title
      t.string :tag_type
      t.integer :position

      t.timestamps
    end


  end


  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-tags"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/tags/tags"})
    end

    drop_table :refinery_tags

  end
end
