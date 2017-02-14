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
//= require tinymce
//= require_tree

$(document).ready(function(){
  $("a.color-link").click(function() {
    var input = $(this).attr('input');
    var attr = 'text_color'
    if (input == 'primary_color') {
      attr = 'color'
    }
    $('#'+input).val($(this).attr(attr));
    $(".color-group-fade").fadeOut();
    return false;
  });

  $(".open-color-group").click(function() {
    var input = $(this).attr('input');
    $('.color-group-fade').fadeOut();
    $('.color-group-fade').fadeIn();
    $('.color-group a').attr('input', input);
    return false;
  });
});