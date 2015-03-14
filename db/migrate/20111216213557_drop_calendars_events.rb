class DropCalendarsEvents < ActiveRecord::Migration
  def up
    drop_table :calendars_events
    drop_table :calendar_events
  end

  def down
    create_table :calendars_events, :id => false  do |t|
      t.references :calendar, :event
    end
    create_table :calendar_events do |t|
      t.references :user
      t.references :event
      t.timestamps
    end
    add_index :calendar_events, :user_id
  end
end
