class MakeVenueCategoryNestedSet < ActiveRecord::Migration
  def up
    add_column :venue_categories, :parent_id, :integer
    add_column :venue_categories, :lft, :integer
    add_column :venue_categories, :rgt, :integer
    add_column :venue_categories, :depth, :integer
  end

  def down
    remove_column :venue_categories, :integer
    remove_column :venue_categories, :integer
    remove_column :venue_categories, :integer
    remove_column :venue_categories, :integer
  end
end
