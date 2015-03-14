class ChangeFieldTypesInCity < ActiveRecord::Migration
  def up
    change_column :cities, :longitude, :float
    change_column :cities, :latitude, :float
  end

  def down
    change_column :cities, :longitude, :string
    change_column :cities, :latitude, :string
  end
end
