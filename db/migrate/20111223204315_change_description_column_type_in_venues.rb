class ChangeDescriptionColumnTypeInVenues < ActiveRecord::Migration
  def up
    change_column(:venues, :description, :text)
  end

  def down
    change_column(:venues, :description, :string)
  end
end
