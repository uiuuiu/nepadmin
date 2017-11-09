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
$('.dropdown').on({

  //fires after dropdown is shown instance method is called.(if you click //anywhere else)
    "shown.bs.dropdown": function() { this.close= false; },

  //when dropdown is clicked
    "click": function() { this.close= true; },

 //when close event is triggered
    "hide.bs.dropdown":  function() { return this.close; }
});
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".