$( document ).ready(function() {
  Shiny.addCustomMessageHandler('disableid', function(arg) {
    $("#" + arg.id).attr("disabled", true)
  })
  Shiny.addCustomMessageHandler('undisableid', function(arg) {
    $("#" + arg.id).attr("disabled", false)
  })
});
$( document ).ready(function() {
  Shiny.addCustomMessageHandler('fun', function(arg) {
  
  })
});
