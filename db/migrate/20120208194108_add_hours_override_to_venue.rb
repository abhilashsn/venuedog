class AddHoursOverrideToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :hours_override, :text
  end
end
