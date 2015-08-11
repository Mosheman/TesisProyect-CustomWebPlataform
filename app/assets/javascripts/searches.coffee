# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

##	 SETING UP FIELD

# KEYWORDS FOR SEARCH
$key_words = $('#keywords')

## STOP CRITERIA
# CHECKBOX TIME ENABLER
$check_period = $('#check_period')

# INPUT TIME
$stop_period = $('#time_stop')

# CHECKBOX DATA ENABLER
$check_data= $('#check_data')

#INPUT DATA
$stop_data = $('#data_stop')

# ACTION FOR SEARCH
$btn_search = $('#search-btn')

# LOG
$test_div = $('#test-div')

#	SETING UP STOP CRITERIA FIELDS

$stop_period.timepicker({ 'timeFormat': 'H:i:s', 'step': 0.5});

$check_period.click ->
  $stop_period.attr 'disabled', !@checked
  return

$check_data.click ->
  $stop_data.attr 'disabled', !@checked
  return

#getFilteredValuesJSON = (url, params) ->
#	$.ajax url,
#		type: 'GET',
#		dataType: 'jsonp',
#		data: params

# BTN_SEARCH ON CLICK
#$btn_search.on 'click', (e) ->
#	$btn_search.disabled = true
#	$btn_search.value = "Buscando..."
#	return

$('#search-form').one 'submit', ->
	$(this).find('input[type="submit"]').prop 'disabled', "disabled"
	$(this).find('input[type="submit"]').prop 'value', "Buscando..."
	target = document.getElementById('search-spinner')
	spinner = new Spinner().spin(target)
	return

#handler = Gmaps.build('Google')
#handler.buildMap {
#  provider: {}
#  internal: id: 'map'
#}, ->
#  markers = handler.addMarkers([ {
#    'lat': 0
#    'lng': 0
#    'picture':
#      'url': 'https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png'
#      'width': 36
#      'height': 36
#    'infowindow': 'hello!'
#  } ])
#  handler.bounds.extendWith markers
#  handler.fitMapToBounds()
#  return

# SLIDER FUNCTIONS

updateRadius = (circle, rad) ->
  circle.setRadius rad*1000 #meters to kms
  return

setSliderListener = (circle) ->
  $('#radius-slider').on 'slide', (slideEvt) ->
    updateRadius circle, slideEvt.value
    return

$('#radius-slider').slider
  orientation: 'horizontal'
  max: 100
  min: 1
  value: 10

$('#radius-slider').slider formatter: (value) ->
  'Radio: ' + value + 'kms'

# GOOGLE MAP FUNCTIONS
map = undefined
myCenter = new (google.maps.LatLng)(-33.448889699999995, -70.6692655)
marker = new (google.maps.Marker)(
  position: myCenter
  draggable: true)

setValueLatLng = (lat, lng) ->
  $('#latitude').prop 'value', lat
  $('#longitude').prop 'value', lng
  return

initialize = ->
  mapProp = 
    center: myCenter
    zoom: 10
    draggable: true
    scrollwheel: true
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new (google.maps.Map)(document.getElementById('map'), mapProp)
  marker.setMap map
  google.maps.event.addListener marker, 'drag', (event) ->
    #infowindow.setContent contentString
    #infowindow.open map, marker
    setValueLatLng event.latLng.lat(), event.latLng.lng()
    return

  google.maps.event.addListener marker, 'dragend', (event) ->
    setValueLatLng event.latLng.lat(), event.latLng.lng()
    return
  
  google.maps.event.addListener map, 'click', (event) ->
    marker.setPosition(event.latLng)
    map.setCenter(event.latLng)
    setValueLatLng event.latLng.lat(), event.latLng.lng()
    return
  
  # Add circle overlay and bind to marker
  circle = new (google.maps.Circle)(
    map: map
    clickable: false
    radius: 10000
    fillColor: '#55BF3B'
    strokeColor: '#313131'
    strokeOpacity: .4
    strokeWeight: .8)
  circle.bindTo 'center', marker, 'position'
  setSliderListener circle
  return

resizeMap = ->
  if typeof map == 'undefined'
    return
  setTimeout (->
    resizingMap()
    return
  ), 400
  return

resizingMap = ->
  if typeof map == 'undefined'
    return
  center = map.getCenter()
  google.maps.event.trigger map, 'resize'
  map.setCenter center
  return

google.maps.event.addDomListener window, 'load', initialize
google.maps.event.addDomListener window, 'resize', resizingMap()


# SHOW MODAL
$('#myModal').on 'show.bs.modal', ->
  #Must wait until the render of the modal appear, thats why we use the resizeMap and NOT resizingMap!! ;-)
  resizeMap()
  return

# DOM Ready
$ ->
  $("#latitude").prop 'value', "-33.448889699999995"
  $("#longitude").prop 'value', "-70.6692655"
