# This migration comes from refinery_one_boxes (originally 1)
class CreateOneBoxesOneBoxes < ActiveRecord::Migration[5.2]

  def up
    create_table :refinery_one_boxes do |t|
      t.boolean :visible
      t.boolean :triangle_overlay
      t.integer :image_id
      t.string :link
      t.integer :position

      t.timestamps
    end


    create_table :refinery_one_box_translations do |t|
      t.string :title
      t.string  :locale, null: false
      t.integer :refinery_one_box_id, null: false
      t.timestamps
    end

    add_index :refinery_one_box_translations, :locale, name: :index_refinery_one_box_translations_on_locale
    add_index :refinery_one_box_translations, [:refinery_one_box_id, :locale], name: :index_95394ba315aed2cb69dea96439990984a765aa44, unique: true

  end


  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-one_boxes"})
    end

    drop_table :refinery_one_boxes

    drop_table :refinery_one_box_translations

  end
end
