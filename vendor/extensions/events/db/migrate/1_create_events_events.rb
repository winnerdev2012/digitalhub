class CreateEventsEvents < ActiveRecord::Migration[5.2]

  def up
    create_table :refinery_events do |t|
      t.string :title
      t.text :description
      t.datetime :start
      t.datetime :end
      t.integer :image_id
      t.string :event_type
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :registration_link
      t.text :accessibility_note
      t.text :translation_note
      t.integer :position

      t.timestamps
    end


  end


  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-events"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/events/events"})
    end

    drop_table :refinery_events

  end
end
