# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


#Google Places API Stuff.
#initialize = ->
#  myLatlng = new google.maps.LatLng(37.783259, -122.402708)
#  myOptions =
#    zoom: 12
#    center: myLatlng
#    mapTypeId: google.maps.MapTypeId.ROADMAP
#
#  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions)
#  places = new google.maps.places.PlacesService(map)
#  google.maps.event.addListener map, "tilesloaded", tilesLoaded
#  autocomplete = new google.maps.places.Autocomplete(document.getElementById("autocomplete"))
#  google.maps.event.addListener autocomplete, "place_changed", ->
#    showSelectedPlace()
#tilesLoaded = ->
#  google.maps.event.clearListeners map, "tilesloaded"
#  google.maps.event.addListener map, "zoom_changed", search
#  google.maps.event.addListener map, "dragend", search
#  search()
#showSelectedPlace = ->
#  clearResults()
#  clearMarkers()
#  place = autocomplete.getPlace()
#  map.panTo place.geometry.location
#  markers[0] = new google.maps.Marker(
#    position: place.geometry.location
#    map: map
#  )
#  iw = new google.maps.InfoWindow(content: getIWContent(place))
#  iw.open map, markers[0]
#search = ->
#  type = undefined
#  i = 0
#
#  while i < document.controls.type.length
#    type = document.controls.type[i].value  if document.controls.type[i].checked
#    i++
#  autocomplete.setBounds map.getBounds()
#  search = bounds: map.getBounds()
#  search.types = [ type ]  unless type is "establishment"
#  places.search search, (results, status) ->
#    if status is google.maps.places.PlacesServiceStatus.OK
#      clearResults()
#      clearMarkers()
#      i = 0
#
#      while i < results.length
#        markers[i] = new google.maps.Marker(
#          position: results[i].geometry.location
#          animation: google.maps.Animation.DROP
#        )
#        google.maps.event.addListener markers[i], "click", getDetails(results[i], i)
#        setTimeout dropMarker(i), i * 100
#        addResult results[i], i
#        i++
#clearMarkers = ->
#  i = 0
#
#  while i < markers.length
#    if markers[i]
#      markers[i].setMap null
#      not markers[i]?
#    i++
#dropMarker = (i) ->
#  ->
#    markers[i].setMap map
#addResult = (result, i) ->
#  results = document.getElementById("results")
#  tr = document.createElement("tr")
#  tr.style.backgroundColor = (if i % 2 is 0 then "#F0F0F0" else "#FFFFFF")
#  tr.onclick = ->
#    google.maps.event.trigger markers[i], "click"
#
#  iconTd = document.createElement("td")
#  nameTd = document.createElement("td")
#  icon = document.createElement("img")
#  icon.src = result.icon
#  icon.setAttribute "class", "placeIcon"
#  name = document.createTextNode(result.name)
#  iconTd.appendChild icon
#  nameTd.appendChild name
#  tr.appendChild iconTd
#  tr.appendChild nameTd
#  results.appendChild tr
#clearResults = ->
#  results = document.getElementById("results")
#  results.removeChild results.childNodes[0]  while results.childNodes[0]
#getDetails = (result, i) ->
#  ->
#    places.getDetails
#      reference: result.reference
#    , showInfoWindow(i)
#showInfoWindow = (i) ->
#  (place, status) ->
#    if iw
#      iw.close()
#      iw = null
#    if status is google.maps.places.PlacesServiceStatus.OK
#      iw = new google.maps.InfoWindow(content: getIWContent(place))
#      iw.open map, markers[i]
#getIWContent = (place) ->
#  content = ""
#  content += "<table><tr><td>"
#  content += "<img class=\"placeIcon\" src=\"" + place.icon + "\"/></td>"
#  content += "<td><b><a href=\"" + place.url + "\">" + place.name + "</a></b>"
#  content += "</td></tr></table>"
#  content
#map = undefined
#places = undefined
#iw = undefined
#markers = []
#autocomplete = undefined

#Load that mess
#$(window).load(initialize)
