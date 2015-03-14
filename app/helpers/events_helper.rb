module EventsHelper


  # Get Unique date for events index, include multiday events
  def get_unique_event_dates(events)
    dates = []
    events.each do |e|
      t0 = e.start_time.to_date
      t1 = e.end_time.blank? ? t0 : e.end_time.to_date

      while t0 <= t1
        dates << t0
        t0 = t0 + 1
      end
    end
    return dates.uniq.sort
  end


  def text_list(listtext,sep1=", ", sep2=", and ")

    n=listtext.size
    if n>1
      (listtext.first(n-1)).join(sep1) + sep2 + listtext.last
    else
      listtext.first
    end

  end



  def listify_tags(c)
    return text_list(c.map { |x| x.name })
  end



  def all_events_for_category(c)

    #category_ids = Category.select('categories.id').where("categories.lft >= #{c.lft} AND categories.lgt <= #{c.rgt}")
    #all_events = Event.select("DISTINCT(events.id)").where("events.id in ?",category_ids)
    #
    if !c.root?
      distinct_events = Event.joins(:categories).select("DISTINCT events.*").where("categories.lft >= #{c.lft} AND categories.lft <= #{c.rgt}")
      return distinct_events
    else
      distinct_events = Event.joins(:categories).select("DISTINCT events.*").descendants
      return distinct_events
    end
  end




  #  Return true if current page was
  #  referred to by homepage
  def from_homepage
    prev = request.referrer
    cur = request.host_with_port
    return false if prev.blank?

     if cur == prev.gsub("http://","").gsub("/","")
       return true
     end

  end




  # Default Event Images for events with no image
  def default_image(category,size)
    return "http://placehold.it/" + size if category.blank?
    if !category.root.blank?
      cat = sanitize_name(category.root.name)
    else
      cat = sanitize_name(category.first.name)
    end

    return "categories/default/" + cat + size + ".jpg"

  end





  # Event Index Page title helper
  def events_show_title(event)
    if !event.venue.blank?
      s = event.name
      s += " | " + event.venue.name
      s += " | " + event.venue.city_name if !event.venue.city_name.blank?
      s += " " + event.venue.state if !event.venue.state.blank?
      return s
    else
      return event.name
    end
  end




end
