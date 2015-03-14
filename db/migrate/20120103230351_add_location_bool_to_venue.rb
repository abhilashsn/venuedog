class AddLocationBoolToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :is_venue, :boolean
  end
end
