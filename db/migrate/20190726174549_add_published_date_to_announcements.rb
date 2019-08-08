class AddPublishedDateToAnnouncements < ActiveRecord::Migration[5.2]
  def change
    add_column :refinery_announcements, :published_date, :datetime
  end
end
