var i = 1;
var array = ["bg1", "bg2", "bg3"];

function changeBG (){
  if ( i > array.length -1) {
    i = 0;
  }
  $('.search-section').removeClass("bg1").removeClass("bg2").removeClass("bg3");
  $('.search-section').addClass(array[i]);
  i++;
}

$(document).ready(function() {

  window.setInterval("changeBG()", 5000);
});
