// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_picture_ = (function() {
  function block_picture_() {
    this.run = bind(this.run, this);
    var css;
    css = "		";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable celeb\" name=\"picture\">\n	PICTURE\n</div>").appendTo(".drag-zone");
  }

  block_picture_.prototype.run = function() {
    return this.drake;
  };

  return block_picture_;

})();