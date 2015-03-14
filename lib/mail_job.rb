class MailJob < Struct.new(:id,:starttime)
  def perform
    calevent = CalendarEvent.find(id)

    #It is 29 hours to take into account the timezone difference

    #May need this someday
    #self.start_time + (now.in_time_zone('Eastern Time (US & Canada)').utc_offset / 86400.0)}

    #ReminderMailer.delay(({:run_at => calevent.event.start_time - 29.hours})).reminder(calevent.user.name,calevent.user.email,calevent.event.id)

    #for testing
    if calevent.has_reminder and !calevent.blank?
      ReminderMailer.reminder(calevent.user.name,calevent.user.email,calevent.event.id).deliver
    end
  end
end


#module MailJob
#
#class ReminderJob
#
# attr_accessor :id, :starttime
# 
#  def initialize(id, starttime)
#    @id = id
#    @starttime = starttime
#  end
#
#  def remind
#    calevent = CalendarEvent.find(@id)
#
#    #It is 29 hours to take into account the timezone difference
#
#    #May need this someday
#    #self.start_time + (now.in_time_zone('Eastern Time (US & Canada)').utc_offset / 86400.0)}
#
#    #ReminderMailer.delay(({:run_at => calevent.event.start_time - 29.hours})).reminder(calevent.user.name,calevent.user.email,calevent.event.id)
#
#    #for testing
#    if calevent.has_reminder and !calevent.blank?
#      ReminderMailer.reminder(calevent.user.name,calevent.user.email,calevent.event.id).deliver
#    end
#  end
#
#  #handle_asynchronously :remind, :run_at => Proc.new { @starttime - 29.hours }
#  handle_asynchronously :remind, :run_at => Proc.new { 5.minutes.from_now - 5.hours }
#
#end
#
#end
