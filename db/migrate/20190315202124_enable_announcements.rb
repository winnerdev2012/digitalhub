class EnableAnnouncements < ActiveRecord::Migration[5.2]
  def up
    Flipper.enable(:announcements)
    Flipper.disable(:action_buttons)
    Flipper.disable(:next_event)
  end

  def down
    Flipper.disable(:announcements)
    Flipper.enable(:action_buttons)
    Flipper.enable(:next_event)
  end
end
