$(document).ready ->

  # Change URL when user selects page
  $("form.choose_city select").change ->
    window.location = "/#{$(this).attr("value")}?&dog=sit"
