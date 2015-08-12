// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_my_location_ = (function() {
  function block_my_location_() {
    this.filter_items = bind(this.filter_items, this);
    this.run = bind(this.run, this);
    var css;
    this.my_location = {
      name: "me",
      instagram_id: null,
      vid_id: null
    };
    css = "		";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable me_block Who\" name=\"my_location\">\n	Me\n</div>").appendTo(".drag-zone");
  }

  block_my_location_.prototype.run = function(cb) {
    return this.my_location;
  };

  block_my_location_.prototype.filter_items = function() {
    var block, i, name, results, temp_list;
    temp_list = $(".draggable.What");
    i = 0;
    results = [];
    while (i < temp_list.length) {
      name = $(temp_list[i]).attr("name");
      block = window["block_" + name];
      if (name === "geocaching") {
        block.filter_items();
      }
      results.push(i++);
    }
    return results;
  };

  return block_my_location_;

})();
