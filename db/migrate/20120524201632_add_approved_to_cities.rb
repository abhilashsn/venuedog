class AddApprovedToCities < ActiveRecord::Migration
  def change
    add_column :cities, :approved, :boolean
  end
end
