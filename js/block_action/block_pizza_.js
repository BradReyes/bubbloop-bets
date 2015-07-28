// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_pizza_ = (function() {
  function block_pizza_() {
    this.run = bind(this.run, this);
    var css;
    css = "#pizza {\n	background-image: url(img/pizza.jpeg);\n	background-size: cover;\n}";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div id=\"pizza\" class=\"drag-wrap draggable action\" name=\"pizza\">\n</div>").appendTo(".drag-zone");
  }

  block_pizza_.prototype.run = function() {
    return window.open("http://order.dominos.com/en/pages/order/#/locations/search/");
  };

  return block_pizza_;

})();
