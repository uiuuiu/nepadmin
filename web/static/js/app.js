// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import "phoenix_ujs"
import $ from "jquery"
import jQuery from 'jquery'
$(document).off('click.bs.dropdown.data-api', '.dropdown form');
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".
$('.radio-submit').click(function(e) {
  var calendar_id = $(this).attr('calendar_id');
  var product_id  = $(this).attr('product_id');
  $.ajax({
    type: "GET",
    url: '/admin/products/' + product_id + '/detail_versions',
    data: {calendar_id: calendar_id}
  });
});
$(".dismiss")(function(){
  $("#notification").fadeOut("slow");
});
