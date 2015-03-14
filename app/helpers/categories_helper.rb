module CategoriesHelper

  def text_list(listtext,sep1=", ", sep2=", and ")

    n=listtext.size
    if n>1
      (listtext.first(n-1)).join(sep1) + sep2 + listtext.last
    else
      listtext.first
    end

  end

  def listify_categories(c)

    return text_list(c.map { |x| x.name })

  end


  def event_time_and_venue(c)
    start_str = c.start_time.strftime("%B %d, %l:%M %P,")
    start_str << " " + c.venue.name if !c.venue.blank?
    return start_str
  end

  def all_events_for_category(c)

    #category_ids = Category.select('categories.id').where("categories.lft >= #{c.lft} AND categories.lgt <= #{c.rgt}")
    #all_events = Event.select("DISTINCT(events.id)").where("events.id in ?",category_ids)
    #
    if !c.root?
      distinct_events = Event.joins(:categories).select("DISTINCT events.*").self_and_descendants
      return distinct_events
    else
      distinct_events = Event.joins(:categories).select("DISTINCT events.*").descendants
      return distinct_events
    end
  end


end
