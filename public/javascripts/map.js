// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var geocoder = null;
var map = null;
var infoWindow = null;

function codeAddress() {
  var address = document.getElementById("address").value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
    } else {
      alert("Geocode was not successful for the following reason: " + status);
    }
  });
}

function map_initialize() {
  geocoder = new google.maps.Geocoder();
  infoWindow = new google.maps.InfoWindow();
  var latlng = new google.maps.LatLng(37.377498,-122.029781);
  var myOptions = {
    zoom: 18,
    disableDoubleClickZoom: true,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.HYBRID,
    tilt: 45
  };
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  google.maps.event.addListener(map, 'dblclick', function(latLng) {
      var geo = latLng.latLng; // yes, its really structured that way
      var point = new google.maps.LatLng(parseFloat(geo.lat()),parseFloat(geo.lng()));
      create_marker(map,point,"Describe me!");   
  });
    if(data_set != null) {  
    jQuery.each(data_set,function(i,location){
    var point = new google.maps.LatLng(parseFloat(location.lat),parseFloat(location.lng))
       if(i == 0) {
            map.panTo(point);
        }
      create_marker(
        map,
        point,
        location.description
      );
    });
  }  
}

function point_to_marker_on_map(point) {
  var marker_identifier = marker_hash(point);

  var location_hash = $('body').data(marker_identifier);
  alert(location_hash.marker);
  if( jQuery.type(location_hash.marker) == 'undefined') {
    return false;
  } else {
    return location_hash.marker;
  }
}

function stripAlphaChars(pstrSource) 
{ 
  var m_strOut = new String(pstrSource); 
  m_strOut = m_strOut.replace(/[^0-9]/g, ''); 
  return m_strOut; 
}

function remove_marker(marker_identifier) {
  var location_hash = $('body').data(marker_identifier);
  if( jQuery.type(location_hash.marker) != 'undefined') {
    location_hash.marker.setMap(null);
    $('#point_'+marker_identifier).remove();
    $('body').removeData(marker_identifier);
    //update_marker_icons();
  } else {
    alert("Marker identifier "+marker_identifier+" does not exist.");
  }
}
function marker_hash(point) 
{
  return stripAlphaChars(point.toUrlValue());
}

function get_marker_icon(digit) {
    var marker_count = digit;
    if(marker_count < 10) {
        marker_count = "0" + marker_count;
    }
    return "/images/black"+marker_count+".png";
}

function update_marker_icons() {
    $('#points').children().each(function(index,li){
        var marker_icon = get_marker_icon(index);
        var jLi = $(li);
        var marker_identifier = jLi.attr('id').split("_")[1];
        var location_hash = $('body').data(marker_identifier);
        location_hash['marker'].setIcon(marker_icon);
        jLi.children('img').attr('src',marker_icon);
    });
}

function toggle_highlight_description(marker_identifier) {
    $('#point_'+marker_identifier).toggleClass('highlighted_li');

}

function create_marker(map, point, text_description) {
    var marker_identifier = marker_hash(point);
    var marker_icon = "/images/GoogleMaps-Marker-RedDot.png"//get_marker_icon($('#points').children().length);  
  var marker = new google.maps.Marker({
    position: point,
    map: map,
    clickable: true,
    draggable: false,
    icon: marker_icon
  });
  
  // add a listener to open the tooltip when a user clicks on one of the markers
  google.maps.event.addListener(marker, 'mouseover', function() {
      fade_bg_in($('#point_'+marker_identifier));

	var container = $('#points_scroller');
	// Or you can animate the scrolling:
	container.animate({
		scrollTop: $('#point_'+marker_identifier).offset().top - container.offset().top + container.scrollTop()
	});

  });
  google.maps.event.addListener(marker, 'mouseout', function() {
      fade_bg_out($('#point_'+marker_identifier));
  });
  var location_hash = {
    'marker':marker,
    'description':text_description,
    'lat':point.lat(),
    'lng':point.lng()
  }
  var input_points = "<input type='text' name='markers["+marker_identifier+"][description]' class='description' value='"+location_hash['description']+"'></input><input type='hidden' name='markers["+marker_identifier+"][lat]' value='"+location_hash['lat']+"'/><input type='hidden' name='markers["+marker_identifier+"][lng]' value='"+location_hash['lng']+"'/>";
  $('#points').append("<li id='point_"+marker_identifier+"'><img class='marker_icon' src='"+marker_icon+"' />"+input_points+" <a href='#' onclick=\"remove_marker(\'"+marker_identifier+"\'); return false;\" class='remove_marker'>x</a></li>");
  
  $('body').data(marker_identifier,location_hash);
}

function fade_bg_in(jDiv) {
    jDiv.stop().animate({ backgroundColor: "#99C68E"}, 200);
}
function fade_bg_out(jDiv) {
    jDiv.stop().animate({ backgroundColor: "#F2F2F2"}, 200);
}

$(document).ready(function() {
    map_initialize();
    $('#points .description, #points img').live('click',function(){
        var marker_identifier = this.parentNode.id.split("_")[1];
        map.panTo($('body').data(marker_identifier).marker.getPosition());
    });

     $("li").live('mouseover', function() { fade_bg_in($(this)); }).live('mouseout',function() { fade_bg_out($(this)); });
});