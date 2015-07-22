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
#	currentValue = $key_words.val()
#	JSONquery = { key_words: {} }
#	JSONquery.key_words = currentValue
#	getFilteredValuesJSON "/searches/search", JSONquery

	# console.log currentValue
