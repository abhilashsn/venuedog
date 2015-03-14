class CleanUpCities < ActiveRecord::Migration
  def up
    remove_column :cities, :event_id
  end

  def down
    add_column :cities, :event_id, :integer
  end
end
