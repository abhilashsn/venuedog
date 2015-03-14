twitterShare = ->
  window.twttr = window.twttr or {}
  D = 550
  A = 450
  C = screen.height
  B = screen.width
  H = Math.round((B / 2) - (D / 2))
  G = 0
  F = document
  E = undefined
  G = Math.round((C / 2) - (A / 2))  if C > A
  window.twttr.shareWin = window.open("http://twitter.com/share", "", "left=" + H + ",top=" + G + ",width=" + D + ",height=" + A + ",personalbar=0,toolbar=0,scrollbars=1,resizable=1")
  E = F.createElement("script")
  E.src = "http://platform.twitter.com/bookmarklets/share.js?v=1"
  F.getElementsByTagName("head")[0].appendChild E
  return

facebookShare = ->
  title = document.title
  fburl = "https://www.facebook.com/sharer/sharer.php?u=#{escape(document.URL)}&t=#{escape(title)}"
  window.facebook = window.facebook or {}
  D = 550
  A = 450
  C = screen.height
  B = screen.width
  H = Math.round((B / 2) - (D / 2))
  G = 0
  G = Math.round((C / 2) - (A / 2))  if C > A
  window.facebook.shareWin = window.open(fburl, "", "left=" + H + ",top=" + G + ",width=" + D + ",height=" + A + ",personalbar=0,toolbar=0,scrollbars=1,resizable=1")
  return


exportEvent = ->
  ics_url = document.URL + ".ics"
  window.open ics_url
  return


$(document).ready ->

  # Date picker for events#new
  dates = $("form #event_start_time_date, form #event_end_time_date").datepicker(
    defaultDate: "+1w"
    changeMonth: true
    numberOfMonths: 3
    onSelect: (selectedDate) ->
      option = (if @id is "event_start_time_date" then "minDate" else "maxDate")
      instance = $(this).data("datepicker")
      date = $.datepicker.parseDate(instance.settings.dateFormat or $.datepicker._defaults.dateFormat, selectedDate, instance.settings)
      dates.not(this).datepicker "option", option, date)

  $("form #event_start_time_clock, form #event_end_time_clock").ptTimeSelect setButtonLabel: "Set"


  # Slide Toggle for events#new category checkboxes
  $(".event_new form .categories ul li.root input.parent").click (e) ->
    $(this).parents("li.root").children("ul.children").slideToggle()

  # Evets category validation on events#new submit
  $('form.new_event').submit (e) ->
    if $('div.categories input[type="checkbox"]:checked').length is 0
      e.preventDefault()
      alert("Please choose categories for your event.")
  


  # Social
  $(".share a.twitter").click(twitterShare)
  $(".share a.add").click(exportEvent)
  $(".share a.facebook").click(facebookShare)
  $(".share a.print").click ->
    window.print()
    return false




  $("body").prepend(
    '<div id="fb-root"></div>
    <script>(function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=296478800397149";
      fjs.parentNode.insertBefore(js, fjs);
      }(document, "script", "facebook-jssdk"));
    </script>')



  # Combo box for events#new venue picker
  $(".event_new select").chosen allow_single_deselect: true


  # Submit "Suggest Venue" modal box form on events#new
  $("#new_venue_info a.submit").click (e) ->
    e.preventDefault
    $("#new_venue_info form.suggest_venue").submit()
    $("#new_venue_info").modal('hide')
    $("#new_venue_success").modal('show')




