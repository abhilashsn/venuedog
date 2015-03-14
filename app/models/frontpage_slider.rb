# == Schema Information
#
# Table name: frontpage_sliders
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#  url                :string(255)
#  weight             :integer(4)      default(0)
#  start_date         :date
#  end_date           :date
#

class FrontpageSlider < ActiveRecord::Base

  belongs_to :city
  has_attached_file :image
  validates :name, :url, :weight, :start_date, :end_date, :city, :presence => true



end
