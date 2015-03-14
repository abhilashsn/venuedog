class AddLocationFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :venue, :string
    add_column :events, :location_name, :string
    add_column :events, :address, :string
    add_column :events, :city, :string
    add_column :events, :state, :string
    add_column :events, :zip, :string
  end
end
