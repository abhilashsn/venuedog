class AddHasReminderToCalendarEvent < ActiveRecord::Migration
  def change
    add_column :calendar_events, :has_reminder, :boolean
  end
end
