$(function () {
  $('[rel="popover"]').popover({ trigger: "hover" })
})

$('#myTabs a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
})

function moveRadiusSlider(handle_id, index, value) {
	console.log("Values: "+handle_id+"," +index+ ","+value);
	updateRadius(circle, value);
}

function slideUISlider(handle_id, index, value) {

	if (0==handle_id.localeCompare("handle_radius")) {
		moveRadiusSlider(handle_id, index, value)
	} else if ( (0==handle_id.localeCompare("handle_valueA")) || (0==handle_id.localeCompare("handle_valueB")) ) {

	}
}

// $("#searchtype-popover").popover({ trigger: "hover" });
// $('#searchtype-popover').popover();