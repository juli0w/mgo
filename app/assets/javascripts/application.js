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
//= require tinymce
//= require_tree .

$(document).ready(function(){
  $('.tooltipped').tooltip({delay: 50});
  $( ".tabs" ).tabs();
  $('select').material_select();
  $(".button-collapse").sideNav();
  $('.carousel').carousel({dist: 0, padding: 50, indicators: false});
  $('.star-rating').rating();

  $('.photo').click(function() {
    $('.img-modal').fadeIn(200);
    $('.img-modal #img-modal').attr('src', $(this).attr('img-full'));
  });

  $('.img-modal .close').click(function() {
    $('.img-modal').fadeOut(200);
  });

  // Get the image and insert it inside the modal - use its "alt" text as a caption
  // var img = document.getElementById('myImg');
  // var modalImg = document.getElementById("img01");
  // var captionText = document.getElementById("caption");
  // img.onclick = function(){
  //     modal.style.display = "block";
  //     modalImg.src = this.src;
  //     captionText.innerHTML = this.alt;
  // }

  // Get the <span> element that closes the modal
  // var span = document.getElementsByClassName("close")[0];
  //
  // // When the user clicks on <span> (x), close the modal
  // span.onclick = function() {
  //     modal.style.display = "none";
  // }
});
