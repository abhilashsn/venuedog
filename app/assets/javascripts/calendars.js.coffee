$ = jQuery
$(document).ready ->

  # Tabs on Dashboard Pages
  $(".users_calendar #tabs, .users_events #tabs").tabs()


  # My Calendar Widget Expand/Collapse on Sidebar
  $("#sidebar .mycalendar a.expand").click (e) ->
    e.preventDefault()
    action = (if ($(this).html() is "Expand") then "Collapse" else "Expand")
    $(".mycalendar .calendar_events").slideToggle("fast")
    $(this).html(action)
