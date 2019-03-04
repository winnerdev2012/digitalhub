class FixEventTimes < ActiveRecord::Migration[5.2]
  def change
    reversible do |direction|
      direction.up do
        # Assumption: times are stored as UTC, but the stored times should have been in America/New_York
        # Convert stored times to eastern and re-save as the correct UTC times
        Refinery::Events::Event.all.each do |event|
          event.update(start: ActiveSupport::TimeZone.new('America/New_York').local_to_utc(event.start),
                       end: ActiveSupport::TimeZone.new('America/New_York').local_to_utc(event.end))
        end
      end

      direction.down do
        # Assume event.start is in UTC, move it to America/New_York time, but return in Time.UTC.
        Refinery::Events::Event.all.each do |event|
          event.update(start: ActiveSupport::TimeZone.new('America/New_York').utc_to_local(event.start),
                       end: ActiveSupport::TimeZone.new('America/New_York').utc_to_local(event.end))
        end
      end
    end
  end
end
