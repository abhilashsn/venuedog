# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#

class User < ActiveRecord::Base

  after_create :setup_user

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :roles, :city, :as => [:default, :super_admin]
  attr_accessible :role_ids, :as => :super_admin

  #has_one :calendar
  has_many :events
  has_many :calendar_events
  #has_many :events, :through => :calendar_events
  has_many :venues
  has_and_belongs_to_many :roles
  belongs_to :city


  # Upcoming Events in User's calendar
  def upcoming_calendar_events
    self.calendar_events.joins(:event).where("DATEDIFF(`start_time`,?) >= 0", Time.now.beginning_of_day)
  end

  # Past events in User's Calendar
  def past_calendar_events
    self.calendar_events.joins(:event).where("DATEDIFF(`start_time`,?) < 0", Time.now.beginning_of_day)
  end




  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    first_name = data.first_name.blank? ? "" : data.first_name
    last_name = data.last_name.blank? ? "" : data.last_name

    if user = User.where(:email => data.email).first
      if user.name.blank?
        user.name = "#{first_name} #{last_name}"
      end
      user
    else # Create a user with a stub password.
      User.create!(:name => "#{first_name} #{last_name}", :email => data.email, :password => Devise.friendly_token[0,20])
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def owner
    self
  end


  # Return user's current city
  # Check user.city, then cookies, then return Rome
  def current_city
    return City.find(1)
  end


  private


  def setup_user
    #Add role.
    self.roles << Role.where(:name => "VenuedogUser").first

    #Send welcome e-mail.
    WelcomeMailer.send_message(self.email).deliver
  end


end
