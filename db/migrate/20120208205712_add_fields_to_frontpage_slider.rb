class AddFieldsToFrontpageSlider < ActiveRecord::Migration
  def change
    add_column :frontpage_sliders, :url, :string
    add_column :frontpage_sliders, :weight, :integer, :default => 0
  end
end
