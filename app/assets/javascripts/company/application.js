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
//= require ../rating
//= require_tree

$(document).ready(function(){
  $('.star-rating').rating();
  $('.tooltipped').tooltip({delay: 50});
  $( ".tabs" ).tabs();

  $('.photo').click(function() {
    $('.img-modal').fadeIn(200);
    $('.img-modal #img-modal').attr('src', $(this).attr('img-full'));
    $('.img-modal #caption').html($(this).attr('desc'));
  });

  $('.img-modal .close').click(function() {
    $('.img-modal').fadeOut(200);
  });
});
