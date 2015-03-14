# == Schema Information
#
# Table name: venues
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
#  street_address     :string(255)
#  city_name          :string(255)
#  state              :string(255)
#  zip                :string(255)
#  phone              :string(255)
#  website            :string(255)
#  phone_alt          :string(255)
#  description        :text
#  holidays           :string(255)
#  monday             :string(255)
#  tuesday            :string(255)
#  wednesday          :string(255)
#  thursday           :string(255)
#  friday             :string(255)
#  saturday           :string(255)
#  sundays            :string(255)
#  facebook           :string(255)
#  twitter            :string(255)
#  staff_name         :string(255)
#  staff_phone        :string(255)
#  staff_email        :string(255)
#  staff_address      :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  is_venue           :boolean(1)
#  user_id            :integer(4)
#  yelp               :string(255)
#  foursquare         :string(255)
#  hours_override     :text
#

class Venue < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Relationships
  has_many :events
  has_many :attachments
  belongs_to :user
  belongs_to :city
  has_and_belongs_to_many :venue_categories

  # Scopes: Sidebar widget, Any featured, is_venue filter
  scope :browse_by, :order => "id DESC", :limit => 5, :conditions => ["`is_venue` = ?", true]
  scope :featured, :order => "RAND()", :limit => 1, :conditions => ["`is_venue` = ?", true]
  scope :real_venues, where(:is_venue => true)
  scope :real_venues_ordered, real_venues.order("name ASC")

  # Imaging
  has_attached_file :image, :styles => { :show => "320x280^" ,:category_show_featured => "240x175^", :homepage_featured=>"230x150^", :index =>"320x200^", :venue_show_thumb => "60x50^" },
              :processor => "mini_magick",
              :convert_options => {
                :show => "-gravity center -extent 320x280",
                :index => "-gravity center -extent 320x200",
                :category_show_featured => "-gravity center -extent 240x175",
                :homepage_featured => "-gravity center -extent 230x150",
                :venue_show_thumb => "-gravity center -extent 60x50",
                :thumb_150x100 => "-gravity center -extent 150x100"
              }



  # Validations
  validates_presence_of :name, :street_address, :city_name, :state, :zip, :description, :image, :city_id
  time_regex = /\A([1-9]|1[0-2]):0*([0-9]|[1-5][0-9]) [AP]M\z/
  #  validates :monday_opensat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :tuesday_opensat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :wednesday_opensat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :thursday_opensat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :friday_opensat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :saturday_opensat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :sunday_opensat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :monday_closesat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :tuesday_closesat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :wednesday_closesat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :thursday_closesat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :friday_closesat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :saturday_closesat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  #  validates :sunday_closesat, :format => { :with => time_regex, :message => "Time format should be: H:MM AM/PM" }, :allow_blank => true
  
  #Monday
  def monday_opensat
    if self.monday.blank? or self.monday_closed
      ""
    else
      logger.debug("\n\n\n\n\n#{self.monday.split("-")[0]}\n\n\n\n\n")
      self.monday.split("-")[0].strip
    end
  end
  
  def monday_closesat
    if self.monday.blank? or self.monday_closed
      ""
    else
      self.monday.split("-")[1].strip
    end
  end
  
  def monday_closed
    if self.monday == "CLOSED"
      true
    else
      false
    end
  end
  
  def monday_opensat=(input)
    t = self.monday
    if t.blank?
      self.monday = "#{input.strip} -"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.monday = "#{input.strip} - #{opentime[1].strip}"
      else
        self.monday = "#{input.strip} - #{opentime[0].strip}"
      end
    end
  end
  
  def monday_closesat=(input)
    t = self.monday
    if t.blank?
      self.monday = "- #{input.strip}"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.monday = "#{opentime[0].strip} - #{input.strip}"
      else
        self.monday = "#{opentime[0]} - #{input.strip}"
      end
    end
  end
  
  def monday_closed=(input)
    if input == "1"
      self.monday = "CLOSED"
    end
  end
  
  #tuesday
  def tuesday_opensat
    if self.tuesday.blank? or self.tuesday_closed
      ""
    else
      self.tuesday.split("-")[0].strip
    end
  end
  
  def tuesday_closesat
    if self.tuesday.blank? or self.tuesday_closed
      ""
    else
      self.tuesday.split("-")[1].strip
    end
  end
  
  def tuesday_closed
    if self.tuesday == "CLOSED"
      true
    else
      false
    end
  end
  
  def tuesday_opensat=(input)
    t = self.tuesday
    if t.blank?
      self.tuesday = "#{input.strip} -"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.tuesday = "#{input.strip} - #{opentime[1].strip}"
      else
        self.tuesday = "#{input.strip} - #{opentime[0].strip}"
      end
    end
  end
  
  def tuesday_closesat=(input)
    t = self.tuesday
    if t.blank?
      self.tuesday = "- #{input.strip}"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.tuesday = "#{opentime[0].strip} - #{input.strip}"
      else
        self.tuesday = "#{opentime[0].strip} - #{input}"
      end
    end
  end
  
  def tuesday_closed=(input)
    if input == "1"
      self.tuesday = "CLOSED"
    end
  end
  #wednesday
  def wednesday_opensat
    if self.wednesday.blank? or self.wednesday_closed
      ""
    else
      self.wednesday.split("-")[0].strip
    end
  end
  
  def wednesday_closesat
    if self.wednesday.blank? or self.wednesday_closed
      ""
    else
      self.wednesday.split("-")[1].strip
    end
  end
  
  def wednesday_closed
    if self.wednesday == "CLOSED"
      true
    else
      false
    end
  end
  
  def wednesday_opensat=(input)
    t = self.wednesday
    if t.blank?
      self.wednesday = "#{input.strip} -"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.wednesday = "#{input.strip} - #{opentime[1].strip}"
      else
        self.wednesday = "#{input.strip} - #{opentime[0].strip}"
      end
    end
  end
  
  def wednesday_closesat=(input)
    t = self.wednesday
    if t.blank?
      self.wednesday = "- #{input}"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.wednesday = "#{opentime[0].strip} - #{input.strip}"
      else
        self.wednesday = "#{opentime[0]} - #{input.strip}"
      end
    end
  end
  
  def wednesday_closed=(input)
    if input == "1"
      self.wednesday = "CLOSED"
    end
  end
  #thursday
  def thursday_opensat
    if self.thursday.blank? or self.thursday_closed
      ""
    else
      self.thursday.split("-")[0].strip
    end
  end
  
  def thursday_closesat
    if self.thursday.blank? or self.thursday_closed
      ""
    else
      self.thursday.split("-")[1].strip
    end
  end
  
  def thursday_closed
    if self.thursday == "CLOSED"
      true
    else
      false
    end
  end
  
  def thursday_opensat=(input)
    t = self.thursday
    if t.blank?
      self.thursday = "#{input.strip} -"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.thursday = "#{input.strip} - #{opentime[1].strip}"
      else
        self.thursday = "#{input.strip} - #{opentime[0].strip}"
      end
    end
  end
  
  def thursday_closesat=(input)
    t = self.thursday
    if t.blank?
      self.thursday = "- #{input.strip}"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.thursday = "#{opentime[0].strip} - #{input.strip}"
      else
        self.thursday = "#{opentime[0]} - #{input.strip}"
      end
    end
  end
  
  def thursday_closed=(input)
    if input == "1"
      self.thursday = "CLOSED"
    end
  end
  #friday
  def friday_opensat
    if self.friday.blank? or self.friday_closed
      ""
    else
      self.friday.split("-")[0].strip
    end
  end
  
  def friday_closesat
    if self.friday.blank? or self.friday_closed
      ""
    else
      self.friday.split("-")[1].strip
    end
  end
  
  def friday_closed
    if self.friday == "CLOSED"
      true
    else
      false
    end
  end
  
  def friday_opensat=(input)
    t = self.friday
    if t.blank?
      self.friday = "#{input.strip} -"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.friday = "#{input.strip} - #{opentime[1].strip}"
      else
        self.friday = "#{input.strip} - #{opentime[0].strip}"
      end
    end
  end
  
  def friday_closesat=(input)
    t = self.friday
    if t.blank?
      self.friday = "- #{input.strip}"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.friday = "#{opentime[0].strip} - #{input.strip}"
      else
        self.friday = "#{opentime[0].strip} - #{input}"
      end
    end
  end
  
  def friday_closed=(input)
    if input == "1"
      self.friday = "CLOSED"
    end
  end
  #saturday
  def saturday_opensat
    if self.saturday.blank? or self.saturday_closed
      ""
    else
      self.saturday.split("-")[0].strip
    end
  end
  
  def saturday_closesat
    if self.saturday.blank? or self.saturday_closed
      ""
    else
      self.saturday.split("-")[1].strip
    end
  end
  
  def saturday_closed
    if self.saturday == "CLOSED"
      true
    else
      false
    end
  end
  
  def saturday_opensat=(input)
    t = self.saturday
    if t.blank?
      self.saturday = "#{input.strip} -"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.saturday = "#{input.strip} - #{opentime[1].strip}"
      else
        self.saturday = "#{input.strip} - #{opentime[0].strip}"
      end
    end
  end
  
  def saturday_closesat=(input)
    t = self.saturday
    if t.blank?
      self.saturday = "- #{input.strip}"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.saturday = "#{opentime[0].strip} - #{input.strip}"
      else
        self.saturday = "#{opentime[0].strip} - #{input}"
      end
    end
  end
  
  def saturday_closed=(input)
    if input == "1"
      self.saturday = "CLOSED"
    end
  end
  #sunday
  def sunday_opensat
    if self.sundays.blank? or self.sunday_closed
      ""
    else
      self.sundays.split("-")[0].strip
    end
  end
  
  def sunday_closesat
    if self.sundays.blank? or self.sunday_closed
      ""
    else
      self.sundays.split("-")[1].strip
    end
  end
  
  def sunday_closed
    if self.sundays == "CLOSED"
      true
    else
      false
    end
  end
  
  def sunday_opensat=(input)
    t = self.sundays
    if t.blank?
      self.sundays = "#{input.strip} -"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.sundays = "#{input.strip} - #{opentime[1].strip}"
      else
        self.sundays = "#{input.strip} - #{opentime[0].strip}"
      end
    end
  end
  
  def sunday_closesat=(input)
    t = self.sundays
    if t.blank?
      self.sundays = "- #{input.strip}"
    elsif t == "CLOSED"
    else
      opentime = t.split("-")
      if opentime.length == 2
        self.sundays = "#{opentime[0].strip} - #{input.strip}"
      else
        self.sundays = "#{opentime[0]} - #{input.strip}"
      end
    end
  end
  
  def sunday_closed=(input)
    if input == "1"
      self.sundays = "CLOSED"
    end
  end

  # String address for Google maps link
  def google_address
    a = []
    a << self.street_address.to_s
    a << self.city_name
    a << self.state
    a << self.zip

    return a.compact.join(",").to_s
  end


  # String address with HTML breaks for convention
  def formatted_address
    a = []
    a << self.street_address + "<br />"
    a << self.city_name + ", "
    a << self.state + " "
    a << self.zip

    return a.compact.join("").to_s.html_safe
  end


  # Determine if there Hours that need to be outputed on #show
  def has_hours?
    return true if !self.hours_override.blank?
    return true if !self.monday.blank?
    return true if !self.tuesday.blank?
    return true if !self.wednesday.blank?
    return true if !self.thursday.blank?
    return true if !self.friday.blank?
    return true if !self.saturday.blank?
    return true if !self.sundays.blank?
  end

  def owner
    self.user
  end



  # Sanitize inputs from frontend
  def sanitize_inputs
    self.description = strip_tags(self.description)
  end


  # Return true if :s_venue => true
  def is_venue?
    if self.is_venue == true
      return true
    else
      return false
    end
  end


  # Search
  def self.search(search)
    if search
      fields = ['name','street_address','city_name','state','zip','description']
      fields.collect! {|x| x + " LIKE '%#{search}%'"}

      return self.where(fields.join(' OR ')).real_venues
    end
  end



end
