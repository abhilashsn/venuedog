# == Schema Information
#
# Table name: wifi_hotspots
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  address    :string(255)
#  longitude  :string(255)
#  latitude   :string(255)
#  city_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class WifiHotspot < ActiveRecord::Base
  belongs_to :city

  validates :name, :address, :city_id, :presence => true

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    "#{self.address} #{self.city.name}, #{self.city.state} #{self.city.zip}"
  end

end
