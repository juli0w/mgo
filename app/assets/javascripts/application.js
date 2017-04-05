// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require materialize
//= require slick
//= require rating
//= require geomap
//= require bg
//= require ahoy
//= require login-modal
//= require_self

$(document).ready(function(){
  // ahoy.trackAll();
  $('.window-modal').modal({
      dismissible: true,
      opacity: 55 });
  $('#modal1').modal('open');

  $('.star-rating').rating();
  $('.tooltipped').tooltip({delay: 50});
  $( ".tabs" ).tabs();
  $('select').material_select();
  $(".open-menu").sideNav();
  $('.collapsible').collapsible();

  $('.slick-sliding').slick({
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 4,
    dots: true,
    arrows: false,
    responsive: [
      {
        breakpoint: 1200,
        settings: {
          slidesToShow: 4,
          slidesToScroll: 4,
        }
      },
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 3,
      }
    },
    {
      breakpoint: 680,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 2
      }
    },
    {
      breakpoint: 460,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    }
  ]
  });
  Materialize.updateTextFields();
});
