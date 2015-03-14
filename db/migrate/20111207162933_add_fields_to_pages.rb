class AddFieldsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :title, :string
    add_column :pages, :content, :text
    add_column :pages, :meta_keywords, :string
    add_column :pages, :meta_description, :string
    add_column :pages, :url, :string
  end
end
