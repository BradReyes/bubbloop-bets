// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_geocaching_ = (function() {
  function block_geocaching_() {
    this.run = bind(this.run, this);
    var css;
    css = "		";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable celeb What\" name=\"geocaching\">\n	geocaching\n</div>").appendTo(".drag-zone");
  }

  block_geocaching_.prototype.run = function() {
    return "geocaching";
  };

  return block_geocaching_;

})();
