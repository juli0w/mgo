$(document).ready(function(){
  $('.modal').modal();
  $(".open-color-group").click(function(){
    $('#color-modal-' + $(this).attr('input')).modal('open');
  });

  $(".color-link").click(function() {
    field = $(this).attr('input');
    id = $(this).attr('data-id');
    color = $(this).attr('data-color');
    $("#hf_"+field).val(id);
    $("#cs-"+field).removeAttr("class").addClass(color).addClass('open-color-group').addClass('color-sample');
    $("#color-modal-"+field).modal("close");
  });
  // $("a.color-link").click(function() {
  //   var input = $(this).attr('input');
  //   var attr = 'text_color';
  //   if (input == 'primary_color') {
  //     attr = 'color';
  //   }
  //   color = $(this).attr(attr);
  //   $('#'+input).val(color);
  //   $('#'+input).next("span").removeAttr("class").addClass($(this).attr('color'));
  //   $(".color-group-fade").fadeOut();
  //   Materialize.updateTextFields();
  //   return false;
  // });
  //
  // $(".open-color-group").click(function() {
  //   var input = $(this).attr('input');
  //   $('.color-group-fade').fadeOut();
  //   $('.color-group-fade').fadeIn();
  //   $('.color-group a').attr('input', input);
  //   return false;
  // });
});
