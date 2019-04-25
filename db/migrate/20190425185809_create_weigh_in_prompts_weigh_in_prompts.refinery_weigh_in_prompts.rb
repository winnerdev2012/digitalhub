# This migration comes from refinery_weigh_in_prompts (originally 1)
class CreateWeighInPromptsWeighInPrompts < ActiveRecord::Migration[5.2]

  def up
    create_table :refinery_weigh_in_prompts do |t|
      t.string :title
      t.integer :image_id
      t.text :body
      t.integer :style
      t.integer :position

      t.timestamps
    end


  end


  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-weigh_in_prompts"})
    end

    drop_table :refinery_weigh_in_prompts

  end
end
