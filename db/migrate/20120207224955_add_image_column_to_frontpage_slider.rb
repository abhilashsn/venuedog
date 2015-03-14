class AddImageColumnToFrontpageSlider < ActiveRecord::Migration
  def change
    change_table :frontpage_sliders do |t|
      t.has_attached_file :image
    end
  end
end
