$(function () {
  $('[rel="popover"]').popover({ trigger: "hover" })
})

$('#myTabs a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
})

// $("#searchtype-popover").popover({ trigger: "hover" });
// $('#searchtype-popover').popover();