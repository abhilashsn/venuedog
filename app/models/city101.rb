# == Schema Information
#
# Table name: city101s
#
#  id          :integer(4)      not null, primary key
#  description :text
#  links       :text
#  created_at  :datetime
#  updated_at  :datetime
#  city_id     :integer(4)
#

class City101 < ActiveRecord::Base
  belongs_to :city
  validates :city_id, :presence => true
end
