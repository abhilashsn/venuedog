class CalendarsHaveAndBelongToManyEvents < ActiveRecord::Migration
  def up
    create_table :calendars_events, :id => false do |t|
       t.references :calendar, :event
    end
  end

  def down
    drop_table :calendars_events
  end
end
