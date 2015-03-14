# == Schema Information
#
# Table name: calendar_events
#
#  id                    :integer(4)      not null, primary key
#  user_id               :integer(4)
#  event_id              :integer(4)
#  users_on_calendar_id  :integer(4)
#  events_on_calendar_id :integer(4)
#  created_at            :datetime
#  updated_at            :datetime
#  has_reminder          :boolean(1)
#

class CalendarEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def owner
    self.user
  end

  #def remind
  #  ReminderMailer.reminder(self.user.name,self.user.email,self.event).deliver
  #end
  #It is 29 hours to take into account the timezone difference
  #handle_asynchronously :remind, :run_at => Proc.new { self.event.start_time - 29.hours } #self.start_time + (now.in_time_zone('Eastern Time (US & Canada)').utc_offset / 86400.0)}

end
