  function initMap() {
    var map;
    var myOptions = {
        zoom: 12,
        center: new google.maps.LatLng(-26.304566, -48.846006)
    };
    map = new google.maps.Map($('#map_canvas')[0], myOptions);

    $.getJSON('/map', null, function(data) { setMap(data); });

    function setMap(datamap) {

      var marker, infowindow;
      for (var x = 0; x < datamap.length; x++) {
          name = datamap[x][0];
          latlng = new google.maps.LatLng(datamap[x][1], datamap[x][2]);
          marker = new google.maps.Marker({
                position: latlng,
                map: map,
                title: name
          });

          var stars = ''
          for (var y = 0; y < 5; y++) {
              stars = stars + '<span class="star';
              if (datamap[x][5] > y) {
                stars = stars + ' fullStar';
              }
              stars = stars + '"></span>'
          }
          var contentStr = '<div class="map-modal">'+
                              '<h5>'+name+'</h5>'+
                              stars +
                              '<br><p>'+datamap[x][3]+'</p>'+
                              '<a href="'+datamap[x][4]+'">Visitar</a>'+
                              ' | <a href="'+datamap[x][4]+'/review">Avaliar</a>'+
                            '</div>';
          infowindow = new google.maps.InfoWindow({
            content: contentStr
          });
          var content = contentStr;
          google.maps.event.addListener(marker,'click', (function(marker,content,infowindow){
            return function() {
                infowindow.setContent(content);
                infowindow.open(map, marker);
            };
        })(marker,content,infowindow));
      }
    }
  }
