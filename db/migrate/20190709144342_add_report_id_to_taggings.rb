class AddReportIdToTaggings < ActiveRecord::Migration[5.2]
  def change
    add_column :refinery_taggings, :report_id, :integer
  end
end
