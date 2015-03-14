module VenuesHelper

  def text_list(listtext,sep1=", ", sep2=", and ")

    n=listtext.size
    if n>1
      (listtext.first(n-1)).join(sep1) + sep2 + listtext.last
    else
      listtext.first
    end

  end

  def listify_venue_categories(c)

    return text_list(c.map { |x| x.name })

  end




  # SEO page title for venues#show
  def venues_show_title(venue)
    s = venue.name
    s += " | " + venue.city_name if !venue.city_name.blank?
    s += " " +venue.state if !venue.state.blank?
    return s
  end




end
