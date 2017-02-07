function initMap(category) {
  var map;
  var myOptions = {
      zoom: 11,
      center: new google.maps.LatLng(-26.304566, -48.846006)
  };
  map = new google.maps.Map($('#map_canvas')[0], myOptions);

  loadMarkers(map, category);
}

function loadMarkers(map, category) {
  $.getJSON('/map', { category: category } , function(data) { setMarkers(map, data); });
}

function setMarkers(map, datamap) {
  var marker;
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

  infowindow = new google.maps.InfoWindow({
    content: content
  });

  google.maps.event.addListener(marker,'click', (function(marker,content,infowindow){
    return function() {
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
    title: company[0]
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
