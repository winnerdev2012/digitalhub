# This migration comes from refinery_stories (originally 1)
class CreateStoriesStories < ActiveRecord::Migration[5.2]

  def up
    create_table :refinery_stories do |t|
      t.string :email
      t.integer :question
      t.boolean :display
      t.integer :position

      t.timestamps
    end


    create_table :refinery_story_translations do |t|
      t.text :response
      t.string  :locale, null: false
      t.integer :refinery_story_id, null: false
      t.timestamps
    end

    add_index :refinery_story_translations, :locale, name: :index_refinery_story_translations_on_locale
    add_index :refinery_story_translations, [:refinery_story_id, :locale], name: :index_845caebe798a0afcd0ff8f6d31a500cb83b87df7, unique: true

  end


  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-stories"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/stories/stories"})
    end

    drop_table :refinery_stories

    drop_table :refinery_story_translations

  end
end
