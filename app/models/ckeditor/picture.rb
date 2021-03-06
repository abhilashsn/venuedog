# == Schema Information
#
# Table name: ckeditor_assets
#
#  id                :integer(4)      not null, primary key
#  data_file_name    :string(255)     not null
#  data_content_type :string(255)
#  data_file_size    :integer(4)
#  assetable_id      :integer(4)
#  assetable_type    :string(30)
#  type              :string(30)
#  created_at        :datetime
#  updated_at        :datetime
#

class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
	                  :styles => { :content => '800>', :thumb => '118x100#' }

	validates_attachment_size :data, :less_than => 2.megabytes
	validates_attachment_presence :data

	def url_content
	  url(:content)
	end
end
