class CreateCategories < ActiveRecord::Migration

  def up
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
    end
  end

  def down
    drop_table :categories
  end

end
