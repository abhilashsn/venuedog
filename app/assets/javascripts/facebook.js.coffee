$(document).ready ->
  callFB()

callFB = ->
  window.fbAsyncInit = ->
    FB.init
      appId: "296478800397149"
      channelURL: "//www.venuedog.com/channel.html"
      status: true
      cookie: true
      oauth: true
      xfbml: true

  ((d) ->
    js = undefined
    id = "facebook-jssdk"
    return  if d.getElementById(id)
    js = d.createElement("script")
    js.id = id
    js.async = true
    js.src = "//connect.facebook.net/en_US/all.js"
    d.getElementsByTagName("head")[0].appendChild js
  ) document
