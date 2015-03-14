class RenameCalendarsToCalendarEvents < ActiveRecord::Migration
  def up
    rename_table :calendars, :calendar_events
  end 
  
  def down
    rename_table :calendar_events, :calendars
  end
end
