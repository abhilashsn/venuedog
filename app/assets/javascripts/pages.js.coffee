$ = jQuery
$(document).ready ->

  $("#slider").nivoSlider
    controlNav: false
    pauseTime: 5000
    effect: "fade"
  # Set Homepage table column heights the same for each rows
  # so that See All links are in vertical line for both rows
  max_hp_row1_height = 0
  max_hp_row2_height = 0
  $(".homepage div.categories ul.category_row1").each ->
    max_hp_row1_height = $(this).height()  if $(this).height() > max_hp_row1_height

  $(".homepage div.categories ul.category_row1").css("height", (max_hp_row1_height + 12) + "px")

  $(".homepage div.categories ul.category_row2").each ->
    max_hp_row2_height = $(this).height()  if $(this).height() > max_hp_row2_height

  $(".homepage div.categories ul.category_row2").css("height", (max_hp_row2_height + 12) + "px")



  # Ad wrap display
  if $("a.ad_page_wrap").length
    $("#container").animate
      marginTop: "95px"
    , "slow", ->
      $("a.ad_page_wrap").slideDown  "slow"
      if $("a.ad_page_wrap").attr("alt").length
        $("body").css "background", $("a.ad_page_wrap").attr("alt")

