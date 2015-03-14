$(document).ready ->
  $("#venue_monday_opensat, #venue_monday_closesat,#venue_tuesday_opensat, #venue_tuesday_closesat,#venue_wednesday_opensat, #venue_wednesday_closesat,#venue_thursday_opensat, #venue_thursday_closesat,#venue_friday_opensat, #venue_friday_closesat,#venue_saturday_opensat, #venue_saturday_closesat,#venue_sunday_opensat, #venue_sunday_closesat").ptTimeSelect setButtonLabel: "Set"
  $(".venue_show #preview_slider").jcarousel()
  $(".venue_show #preview_slider a").click (e) ->
    e.preventDefault()
    full_image = $(this).attr("href")
    $(".venue_show .main_image img").fadeOut(500, ->
      $(".venue_show .main_image img").attr "src", full_image
    ).fadeIn 500


  # Venue select :onchange for venues#all_events
  $('.venue_all_events form select#venue_id').change ->
    city_id = $(this).data("city")
    venue = "/#{city_id}/venues/#{$(this).val()}/all-events"
    window.location = venue
