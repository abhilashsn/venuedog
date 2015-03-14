module ApplicationHelper


  # Quick break clear of floats
  def clear
    return '<div class="clear"></div>'.html_safe
  end
  def clear_li
    return '<li class="clear"></li>'.html_safe
  end


  def email_is_valid?(email)
    valid_email = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
    if valid_email.match(email.to_s)
      return true
    else
      return false
    end
  end




  # Default meta information
  def meta_description
    m = 'VenueDog is the master calendar for all events and venues in Rome GA. If you are looking for what\'s happening or what to do, go to venuedog.com!'
   return m.to_s.html_safe
  end

  def meta_keywords
    m = ['VenueDog', 'venue dog', 'events', 'event', 'calendar', 'venues', 'whats happening', 'rome ga', 'visiting', 'things to do']
    return m.join(',').html_safe
  end




  # Sanitize a string for use ass CSS id
  def sanitize_name(str)
    str.gsub(' ','_').downcase.gsub("&", "and")
  end






  # Add bootstrap CSS flash messages in the future maybe.
  def twitterized_type(type)
    case type
      when :alert
        "warning"
      when :error
        "error"
      when :notice
        "info"
      when :success
        "success"
      else
        type.to_s
    end
  end



  def on_homepage?
    current_page?(root_path)
  end


  def on_city_homepage?
    if controller.controller_name == "cities" and controller.action_name == "homepage"
      return true
    else
      return false
    end
  end


  def decode_entities(s)
    HTMLEntities.new.decode s
  end

end
