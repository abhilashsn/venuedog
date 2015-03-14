# == Schema Information
#
# Table name: ads
#
#  id                     :integer(4)      not null, primary key
#  advertiser_id          :integer(4)
#  name                   :string(255)
#  start                  :datetime
#  end                    :datetime
#  size                   :string(255)
#  destination            :string(255)
#  image_file_name        :string(255)
#  image_content_type     :string(255)
#  image_file_size        :integer(4)
#  image_uploaded_at      :datetime
#  notes                  :text
#  locations              :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  on_homepage            :boolean(1)
#  page_wrap_file_name    :string(255)
#  page_wrap_file_size    :string(255)
#  page_wrap_content_type :integer(4)
#  page_wrap_updated_at   :datetime
#  background_color       :string(255)
#

class Ad < ActiveRecord::Base

  belongs_to :advertiser
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :cities

  # Basic/simplistic Ad scopes, Ad date, enforce Advertiser uniqueness (Prevent all ads on one page being from same advertiser)
  scope :active, where("start < ? AND end > ?", Time.now, Time.now)
  scope :sidebar_120x240, active.where(:size => "Sidebar Half (120x240)").limit(2).order("RAND()")
  scope :city101_125x125, active.where(:size => "City 101 (125x125)").limit(16).order("RAND()")
  scope :sidebar_250x250, active.where(:size => "Sidebar Full (250x250)").limit(1).order("RAND()")
  scope :header_470x60, active.where(:size => "Header (470x60)").limit(1).order("RAND()")
  scope :on_homepage, active.where("on_homepage is true OR page_wrap_content_type > 0")
  scope :on_global_homepage, active.where("on_global_homepage is true").order("RAND()")

  validate :has_city?


  # Imaging
  has_attached_file :image, :processor => "mini_magick"
  has_attached_file :page_wrap, :processor => "mini_magick"


  # Ad Sizes
  def size_enum
    ["Sidebar Full (250x250)", "Sidebar Half (120x240)", "Header (470x60)", "City 101 (125x125)"]
  end


  # Ad locations
  def locations_enum
    ["Whole Site", "Venue Pages", "Individual Event Pages", "Static Pages"]
  end



  # Make sure that ad has at least one city
  def has_city?
    self.errors.add :base, "Ad must have at least one city." if self.cities.blank?
  end


end
