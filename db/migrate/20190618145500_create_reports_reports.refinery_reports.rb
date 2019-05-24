# This migration comes from refinery_reports (originally 1)
class CreateReportsReports < ActiveRecord::Migration[5.2]

  def up
    create_table :refinery_reports do |t|
      t.string :title
      t.text :body
      t.datetime :date
      t.integer :image_id
      t.integer :position

      t.timestamps
    end


  end


  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-reports"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/reports/reports"})
    end

    drop_table :refinery_reports

  end
end
