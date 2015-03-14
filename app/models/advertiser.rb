# == Schema Information
#
# Table name: advertisers
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  address_line_1 :string(255)
#  address_line_2 :string(255)
#  city           :string(255)
#  state          :string(255)
#  zip            :string(255)
#  phone          :string(255)
#  website        :string(255)
#  contact_name   :string(255)
#  contact_phone  :string(255)
#  contact_email  :string(255)
#  budget_amount  :string(255)
#  period         :string(255)
#  notes          :text
#  created_at     :datetime
#  updated_at     :datetime
#

class Advertiser < ActiveRecord::Base

  has_many :ads

end
