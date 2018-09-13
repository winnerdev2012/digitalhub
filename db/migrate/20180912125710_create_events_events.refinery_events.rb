# This migration comes from refinery_events (originally 1)
class CreateEventsEvents < ActiveRecord::Migration[5.2]

  def up
    create_table :refinery_events do |t|
      t.datetime :start
      t.datetime :end
      t.integer :image_id
      t.string :event_type
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :registration_link
      t.integer :position

      t.timestamps
    end


    create_table :refinery_event_translations do |t|
      t.string :title
      t.text :description
      t.text :accessibility_note
      t.text :translation_note
      t.string  :locale, null: false
      t.integer :refinery_event_id, null: false
      t.timestamps
    end

    add_index :refinery_event_translations, :locale, name: :index_refinery_event_translations_on_locale
    add_index :refinery_event_translations, [:refinery_event_id, :locale], name: :index_ef835b16deb790211db3f38fe084065f37a4862b, unique: true

  end


  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-events"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/events/events"})
    end

    drop_table :refinery_events

    drop_table :refinery_event_translations

  end
end
