class RemoveVenueFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :venue
  end

  def down
    add_column :events, :venue, :string
  end
end
