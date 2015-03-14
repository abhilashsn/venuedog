class RemoveFieldsFromCity101 < ActiveRecord::Migration
  def up
    remove_column :city101s, :city
    remove_column :city101s, :longitude
    remove_column :city101s, :latitude
  end

  def down
    add_column :city101s, :latitude, :float
    add_column :city101s, :longitude, :float
    add_column :city101s, :city, :string
  end
end
