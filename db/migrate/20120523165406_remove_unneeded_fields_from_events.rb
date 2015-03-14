class RemoveUnneededFieldsFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :location_name
    remove_column :events, :address
    remove_column :events, :city
    remove_column :events, :state
    remove_column :events, :zip
  end

  def down
    remove_column :events, :location_name, :string
    remove_column :events, :address, :string
    remove_column :events, :city, :string
    remove_column :events, :state, :string
    remove_column :events, :zip, :string
  end

end
