# == Schema Information
#
# Table name: venue_categories
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer(4)
#  lft        :integer(4)
#  rgt        :integer(4)
#  depth      :integer(4)
#

class VenueCategory < ActiveRecord::Base
  acts_as_nested_set
  has_and_belongs_to_many :venues
end
