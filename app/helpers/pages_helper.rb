module PagesHelper

  def get_events(cat)
    events = cat.self_and_descendants.map{|x| x.events.where(:city_id => @city.id).upcoming.approved}.flatten.uniq[0..4]
    return events
  end




  # Event tracking JS for GA event tracking
  # returns string for link onclick
  def ga_ad_click(advertiser, ad_name, link)
    adv = advertiser.blank? ? "" : advertiser
    adv_name = ad_name.blank? ? "" : ad_name
    #adv_link = link.blank? ? "" : link
    category = adv + " - Ad Data"
    action = adv_name + " - Clicks"

    adv_link = request.url
    result = "_gaq.push(['_trackEvent', '" + category + "', '" + action + "', '" + adv_link +"']);"

    # Tell rails not to escape output.
    result.html_safe
  end


  # Ad Impression Tracking on GA
  #  Return JS call to track add impresion
  def ga_track_ad_impression(ad)
    adv = ad.advertiser.blank? ? "UNKNOWN" : ad.advertiser.name
    category = adv + " - Ad Data"

    ad_name = ad.name.blank? ? "UNKNOWN" : ad.name
    action = ad_name + " - Impressions"

    #adv_link = ad.destination.blank? ? "" : ad.destination
    adv_link = request.url

    # _gaq.push(['_trackEvent', 'category', 'action', 'label']);
    result = "_gaq.push(['_trackEvent', '" + category + "', '" + action + "', '" + adv_link +"']);"

    # Tell rails not to escape the output.
    result.html_safe
  end


end
