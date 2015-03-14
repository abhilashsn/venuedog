class AddDatesToFrontpageSlider < ActiveRecord::Migration
  def change
    add_column :frontpage_sliders, :start_date, :date
    add_column :frontpage_sliders, :end_date, :date
  end
end
