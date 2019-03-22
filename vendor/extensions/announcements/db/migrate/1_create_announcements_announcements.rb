class CreateAnnouncementsAnnouncements < ActiveRecord::Migration[5.2]

  def up
    create_table :refinery_announcements do |t|
      t.integer :image_id
      t.string :link
      t.integer :position

      t.timestamps
    end


    create_table :refinery_announcement_translations do |t|
      t.string :title
      t.text :body
      t.string  :locale, null: false
      t.integer :refinery_announcement_id, null: false
      t.timestamps
    end

    add_index :refinery_announcement_translations, :locale, name: :index_refinery_announcement_translations_on_locale
    add_index :refinery_announcement_translations, [:refinery_announcement_id, :locale], name: :index_1e4a4b96bfcc2c70b6dced31b103aba9ca46fd70, unique: true

  end


  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-announcements"})
    end

    drop_table :refinery_announcements

    drop_table :refinery_announcement_translations

  end
end
