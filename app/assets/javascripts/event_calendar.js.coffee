$ = jQuery
$(document).ready ->

  # Implement color scheme on calendar

  # Equation for color vector in RGB Space
  # Assumes ||pl|| > ||pd|| (from origin)
  color_vector = (pl, pd, z) ->
    r_hat = (pd[0] - pl[0]) * z + pl[0]
    g_hat = (pd[1] - pl[1]) * z + pl[1]
    b_hat = (pd[2] - pl[2]) * z + pl[2]
    [ parseInt(r_hat), parseInt(g_hat), parseInt(b_hat) ]


  # Return a color given number of events and e_max
  get_vector_color = (n, e_max) ->
    return null  if e_max is 0 or n is 0

    pd = [224,93,67]
    pl = [248,216,210]

    s = n / e_max
    color_vector pl, pd, s

  # Convert RGB tp HEX
  rgb2hex = (lst) ->
    r = parseInt(lst[0]).toString(16)
    r = (if (r.length < 2) then "0" + r else r)
    g = parseInt(lst[1]).toString(16)
    g = (if (g.length < 2) then "0" + g else g)
    b = parseInt(lst[2]).toString(16)
    b = (if (b.length < 2) then "0" + b else b)
    r + g + b



  # Get Events Per Day JSON and apply calculated color to day
  set_calendar_color_scheme = ( year, month, city_id ) ->
    if city_id
      e_max = 0
      $.getJSON "/events-per-day/#{city_id}/#{year}/#{month}/events-per-day.json", (data) ->
  
        $.each data, (day, n_events) ->
          e_max = n_events  if n_events > e_max
  
        cal_days = "#sidebar #event_calendar table.ui-datepicker-calendar td a"
        $(cal_days).each ->
          n_events = data[parseInt($(this).text())]
          color = get_vector_color(n_events, e_max)
          $(this).css("background", "#" + rgb2hex(color) ) if color?


  # Create calendar and bind re/colorization to month change
  $("#event_calendar").datepicker
    
    onSelect: (dateText) ->
      city_slug = $("#event_calendar").data("city_slug")
      date = undefined
      selectedDate = encodeURI(new Date(dateText))
      window.location.href = "/show-by-date/" + selectedDate
      window.location.href = "/#{city_slug}/show-by-date/" + selectedDate
      
    onChangeMonthYear: (year,month) ->
      city_id = $(this).data("city_id")
      set_calendar_color_scheme( year, month, city_id )
      
      
  e_date = new Date()
  set_calendar_color_scheme(e_date.getFullYear(), e_date.getMonth() + 1, $("#event_calendar").data("city_id") )
