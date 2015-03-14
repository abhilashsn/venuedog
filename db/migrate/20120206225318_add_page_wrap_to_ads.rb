class AddPageWrapToAds < ActiveRecord::Migration
  def change
    add_column :ads, :page_wrap_file_name, :string
    add_column :ads, :page_wrap_file_size, :string
    add_column :ads, :page_wrap_content_type, :integer
    add_column :ads, :page_wrap_updated_at, :datetime
  end
end
