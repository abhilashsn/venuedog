class CategoriesHaveAndBelongToManyEvents < ActiveRecord::Migration
  def up
    create_table :categories_events, :id => false do |t|
      t.references :category, :event
    end
  end

  def down
    drop_table :categories_events
  end
end
