class CreateFrontpageSliders < ActiveRecord::Migration
  def change
    create_table :frontpage_sliders do |t|
      t.string :name

      t.timestamps
    end
  end
end
