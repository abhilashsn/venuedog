# == Schema Information
#
# Table name: cities
#
#  id         :integer(4)      not null, primary key
#  event_id   :integer(4)
#  name       :string(255)
#  longitude  :float
#  latitude   :float
#  created_at :datetime
#  updated_at :datetime
#  zip        :string(255)
#  state      :string(255)
#

class City < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged

  # Associations
  has_one :city101
  has_many :wifi_hotspots
  has_many :events
  has_many :users
  has_many :venues
  has_many :frontpage_sliders
  validates :name, :state, :zip, :presence => true
  has_and_belongs_to_many :ads

  geocoded_by :full_address
  after_validation :geocode

  scope :approved, where(:approved=>true)

  def self.by_states
    self.find(:all).sort_by{ |city| city.name }.group_by{ |city| city.state }.sort
  end

  def state_enum
    ["AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PW", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY"]
  end

  def full_address
    "#{self.name}, #{self.state}"
  end


end
