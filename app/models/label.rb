# == Schema Information
#
# Table name: labels
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

class Label < ActiveRecord::Base
  has_and_belongs_to_many :events

end
