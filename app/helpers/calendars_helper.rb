module CalendarsHelper

  def events_count_helper(num)
    if num == 1
      return "#{num} event"
    else
      return "#{num} events"
    end
  end

  def people_attending_helper(num)

    if num == 1
      return "#{num} Person Attending"
    else
      return "#{num} People Attending"
    end
  end

end
