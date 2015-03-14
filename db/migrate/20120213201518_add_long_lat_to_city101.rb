class AddLongLatToCity101 < ActiveRecord::Migration
  def change
    add_column :city101s, :longitude, :float
    add_column :city101s, :latitude, :float
  end
end
