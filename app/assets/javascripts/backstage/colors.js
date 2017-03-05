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
    $("#cs-"+field).attr('data-tooltip', color);
    $("#cs-"+field).tooltip();
    $("#cs-"+field).removeAttr("class").addClass(color).addClass('open-color-group').addClass('color-sample');
    $("#color-modal-"+field).modal("close");
  });
});
