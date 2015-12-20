$(function () {
  $('[rel="popover"]').popover({ trigger: "hover" })
})

$('#myTabs a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
})

function slideUISlider(handle_id, value, text) {
	console.log("Values: "+handle_id+"," +value+ ","+text);
}
// $("#searchtype-popover").popover({ trigger: "hover" });
// $('#searchtype-popover').popover();