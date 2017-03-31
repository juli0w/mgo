$(document).ready(function() {
  $(document).click(function(event) {
    if(!$(event.target).closest('.modalf-content').length) {
      if($('.modalf-content').is(":visible")) {
          $('.modalf').fadeOut();
      }
    }
  })
});
