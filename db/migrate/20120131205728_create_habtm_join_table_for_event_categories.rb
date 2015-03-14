class CreateHabtmJoinTableForEventCategories < ActiveRecord::Migration
  def up

    create_table :venue_categories_venues, :id => false do |t|
      t.references :venue, :null => false
      t.references :venue_category, :null => false
    end
    add_index( :venue_categories_venues, [:venue_id, :venue_category_id], :unique => true)

  end

  def down
    drop_table :venue_categories_venues
  end

end
