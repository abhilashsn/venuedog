# == Schema Information
#
# Table name: events
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)
#  name               :string(255)
#  start_time         :datetime
#  end_time           :datetime
#  all_day            :boolean(1)
#  created_at         :datetime
#  updated_at         :datetime
#  location_name      :string(255)
#  description        :text
#  price              :string(255)
#  website            :string(255)
#  event_host         :string(255)
#  event_contact      :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#  venue_id           :integer(4)
#  approved           :boolean(1)
#  buy_tickets        :string(255)
#

class Event < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper
  extend FriendlyId
  friendly_id :name, use: :slugged


  # Associations
  belongs_to :user
  belongs_to :venue
  belongs_to :city
  has_many :calendar_events
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :categories

  # Config
  # Create Venue on events#new for fake venue
  attr_accessor :venue_attributes


  # Scopes
  time_as_current = Time.now
  utcoffset = (time_as_current.in_time_zone('Eastern Time (US & Canada)').utc_offset / 3600) * -1
  curr_time = (time_as_current + utcoffset.hours).to_s(:db)
  # scope :upcoming, :order => "`start_time` ASC", :conditions => ["DATEDIFF(`start_time`,?) >= 0", curr_time]
  scope :upcoming, :order => "`start_time` ASC", :conditions => ["TIME_TO_SEC(TIMEDIFF(`start_time`,?)) >= 0 OR (start_time < ? AND end_time >= ? AND end_time IS NOT NULL)", curr_time, curr_time, curr_time]

  #Replaced Time.now in these scopes with curr_time
  scope :widget, :order => "`start_time` ASC", :limit=>6, :conditions => ["`start_time` >= ? AND approved=?", curr_time, true]
  scope :featured_homepage, :order => "`start_time` ASC", :limit=>4, :conditions => ["`start_time` >= ? AND approved=?", curr_time, true]
  scope :approved, where(:approved => true)
  #before_validation :combine_date_times


  has_attached_file :image, :styles => { :event_show_thumb => "100x100^" ,:category_event_thumb => "70x70^", :featured_small=>"42x42^", :profile => "220x300^", :event_show => "320x235^", :category_show_featured => "240x175^", :event_100x90=>"100x90^" },
              :processor => "mini_magick",
              :convert_options => {
                :event_show_thumb => "-gravity center -extent 100x100",
                :featured_small => "-gravity center -extent 42x42",
                :category_event_thumb => "-gravity center -extent 70x70",
                :profile => "-gravity center -extent 220x300",
                :event_show => "-gravity center -extent 320x235",
                :category_show_featured => "-gravity center -extent 240x175",
                :event_100x90 => "-gravity center -extent 100x90"
              }


  # Validations
  validates :name, :start_time, :categories, :description, :event_host, :event_contact, :city_id, :presence => true
  validates :name, :length => { :minimum => 2 }
  validates :name, :length => { :maximum => 40 }
  validates_presence_of :venue, :message => " or event location is required.", :on => :create





  def save_a_copy()
  end

  def save_a_copy=(input)
    if input == "1"
      cpy = self.dup
      cpy.categories = self.categories
      cpy.labels = self.labels
      cpy.user = self.user
      #cpy.image = self.image
      cpy.save
    end
  end


  def self.show_by_date(d)
    begin
      t = Time.parse(d)
      first_of_day = t.beginning_of_day.to_s(:db)
      end_of_day = t.end_of_day.to_s(:db)

      return approved.where("(start_time >= ? AND start_time <= ?) or (start_time < ? and end_time > ?)", first_of_day, end_of_day, first_of_day, first_of_day)
    rescue
      return self.all
    end
  end


  def self.popular_homepage
    pop =  self.upcoming.joins(:calendar_events).group("calendar_events.event_id").order('count_id').limit(4).count('id')
    results = []
    pop.each_pair do |k,v|
        results << self.find(k.to_i)
    end

    return results
  end


  # Used in beta api
  def self.popular_homepage_rome
    pop =  self.approved.where("city_id = ?", 1).upcoming.joins(:calendar_events).group("calendar_events.event_id").order('count_id').limit(4).count('id')
    results = []
    pop.each_pair do |k,v|
        results << self.find(k.to_i)
    end

    return results
  end


  # Get events in month, Start time or end time is in month
  def self.month(year,month)
    t0 = DateTime.new(year.to_i, month.to_i, 1)
    t1 = t0.end_of_month + 1
    where("(start_time >= ? AND start_time < ? ) OR (end_time >= ? AND end_time < ?)", t0, t1, t0, t1)
  end

  # Get events in date range, inclusive
  def self.in_range(from_t,to_t)
   t0 = from_t.beginning_of_day.to_s(:db)
   t1 = to_t.to_date.end_of_day.to_s(:db)
   #where("(start_time >= ? AND start_time <= ?) OR (start_time <= ? and end_time >= ?)", t0, t1, t0, t1)
   #where("(DATEDIFF(`start_time`,?) >= 0 AND DATEDIFF(`start_time`,?) <= 0) OR (start_time <= ? AND end_time >= ?)", t0, t1, t0, t1)
   where("(start_time BETWEEN ? AND ?) OR (start_time <= ? AND end_time >= ?)", t0, t1, t1, t0)
  end






  # Virtual Fields for frontend date/time picker
  # Start Time
  # Get
  def start_time_date
    # a = start_time_date.strftime("%m/%d/%Y")
    # logger.debug(start_time_date.strftime("%m/%d/%Y"))
  end
  # Set
  def start_time_date=(date)
  #  self.start_time_date = date
  end
  def st
  end


  def start_time_clock
  end
  def start_time_clock=(time)
  end


  # End Time
  def end_time_date
  end
  def end_time_date=(date)
  end

  def end_time_clock
  end
  def end_time_clock=(time)
  end

  # Combine date and time fields on events#new
  def combine_date_times
    logger.debug('-------------------------')
    logger.debug(self.inspect)
    logger.debug(self.start_time_date)
    logger.debug('-------------------------')
  end



  def to_ical()
    loc = [self.venue.name, self.venue.street_address, self.venue.city_name, self.venue.state, self.venue.zip].join("\n")
    event = RiCal.Event do |e|
      e.description =  self.description
      e.dtstart =     self.start_time.strftime("%Y%m%dT%H%M%S")
      if !self.end_time.nil?
        e.dtend =       self.end_time.strftime("%Y%m%dT%H%M%S")
      end
      e.location =    loc
    end

    return event.export()
  end


  # String address for Google maps link
  def google_address
    a = []
    a << self.venue.street_address.to_s
    a << self.venue.city_name
    a << self.venue.state
    a << self.venue.zip

    return a.compact.join(",").to_s
  end



  # Search
  def self.search(search)
    if search
      fields = ['name','description','price','website','event_host','event_contact']
      fields.collect! {|x| x + " LIKE '%#{search}%'"}

      return self.where(fields.join(' OR ')).upcoming.approved
    end
  end


  def owner
    self.user
  end



  def venue_attributes(delta_venue)
  end



  # Sanitize inputs from frontend
  def sanitize_inputs
    self.description = strip_tags(self.description)
  end


end
