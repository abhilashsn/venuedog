// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require fancybox
//= require jquery.nivo.slider
//= require jquery.combobox
//= require jquery.jcarousel.min
//= require jquery.ptTimeSelect
//= require jquery.uniform
//= require cities
//= require_tree .

$(document).ready(function(){


 /** 
  *  Browse By Date, Category, and Venue Widget.
  *  Sets cookie when state changes
  */
  $("#sidebar .browse_by .head a").click( function(e){
    e.preventDefault();
    holder = $(this);
    $(this).parent().next(".browser").slideToggle(400, function(){
      state = $(holder).children("span").attr("class") == "plus" ? "minus" : "plus";

      cookie_name = $(holder).attr('class');
      open = (state == "minus")? 1:0;
      $.cookie(cookie_name, open, { expires: 7 });
      
      $(holder).children("span").attr("class",state);
    });
  });





  /* Cross Browser Form Styling */
  $("form .uniform, input:file, input:checkbox").uniform();


  /* Twitter Bootstrap Alert message closer */
  $(".alert-message").alert();


  /* HTML5 Placeholder Fix */
  if ($.browser.msie){
    $("input").each( function(){
      if($(this).val()=="" && $(this).attr("placeholder")!=""){
        $(this).val($(this).attr("placeholder"));
        $(this).focus(function(){
          if($(this).val()==$(this).attr("placeholder")) $(this).val("");
        });
        $(this).blur(function(){
          if($(this).val()=="") $(this).val($(this).attr("placeholder"));
        });
      }
    });
  }
  

});
