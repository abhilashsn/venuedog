class AddZipToCity < ActiveRecord::Migration
  def change
    add_column :cities, :zip, :string
  end
end
