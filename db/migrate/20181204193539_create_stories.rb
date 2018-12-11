class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :email
      t.integer :question

      t.timestamps
    end
  end
end
