class AddCalendarEventsTable < ActiveRecord::Migration
  def up
    create_table :calendar_events do |t|
        t.integer :user_id
        t.integer :event_id
        t.integer :users_on_calendar_id
        t.integer :events_on_calendar_id
        t.timestamps
    end
  end

  def down
    drop_table :calendar_events
  end
end
