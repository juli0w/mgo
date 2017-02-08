function initMap(category) {
  var map, myLatlng;
  myLatlng = new google.maps.LatLng(-26.304566, -48.846006);
  var myOptions = {
      zoom: 11,
      center: myLatlng
  };
  map = new google.maps.Map($('#map_canvas')[0], myOptions);

  var tab = $("#list-map-tab");
  $("#list-map-tab").click(function(){
    google.maps.event.trigger(map, 'resize');
    //fire a center event after the resize, this is also useful
    // if bound to a window resize
    map.setCenter(myLatlng)
  });

  $(document).ready(function() { map.setCenter(myLatlng) });

  loadMarkers(map, category);
}

function loadMarkers(map, category) {
  $.getJSON('/map', { category: category } , function(data) { setMarkers(map, data); });
}

function setMarkers(map, datamap) {
  var marker, old;
  for (var x = 0; x < datamap.length; x++) {
    marker = createMark(map, datamap[x]);
    createWindow(marker, map, datamap[x]);
  }
}

function createWindow(marker, map, company) {
  var infowindow, content;
  var content = '<div class="map-modal">'+
                    '<h5>'+company[0]+'</h5>'+
                    createStars(company[5]) +
                    '<br><p>'+company[3]+'</p>'+
                    '<a href="'+company[4]+'">Visitar</a>'+
                    ' | <a href="'+company[4]+'/review">Avaliar</a>'+
                  '</div>';


  google.maps.event.addListener(marker,'click', (function(marker,content,infowindow){
    return function() {
      infowindow = new google.maps.InfoWindow({
        content: content
      });

      infowindow.setContent(content);
      infowindow.open(map, marker);
    };
  })(marker,content,infowindow));
}

function createMark(map, company) {
  latlng = new google.maps.LatLng(company[1], company[2]);
  marker = new google.maps.Marker({
    position: latlng,
    map: map,
    title: company[0],
    clickable : true
  });

  return marker;
}

function createStars(note) {
  var stars = "";
  for (var y = 0; y < 5; y++) {
    stars = stars + '<span class="star';
    if (note > y) {
      stars = stars + ' fullStar';
    }
    stars = stars + '"></span>'
  }
  return stars;
}
