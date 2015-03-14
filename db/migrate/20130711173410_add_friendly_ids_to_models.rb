class AddFriendlyIdsToModels < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string
    add_index :categories, :slug, :unique => true

    add_column :venues, :slug, :string
    add_index :venues, :slug, :unique => true

    add_column :cities, :slug, :string
    add_index :cities, :slug, :unique => true
  end
end
