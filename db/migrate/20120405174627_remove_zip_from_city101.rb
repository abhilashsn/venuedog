class RemoveZipFromCity101 < ActiveRecord::Migration
  def up
    remove_column :city101s, :zip
  end

  def down
    add_column :city101s, :zip, :string
  end
end
