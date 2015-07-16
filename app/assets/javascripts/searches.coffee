# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


getFilteredValuesJSON = (url, params) ->
	$.ajax url,
		type: 'GET',
		dataType: 'jsonp',
		data: params

$key_words = $('#key_words')
$test_div = $('#test-div')
$btn_search = $('#search-btn')

# BTN_SEARCH ON CLICK
$btn_search.on 'click', (e) ->
	currentValue = $key_words.val()
	JSONquery = { key_words: {} }
	JSONquery.key_words = currentValue
	getFilteredValuesJSON "/searches/search", JSONquery

	# console.log currentValue