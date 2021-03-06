// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_selenagomez_ = (function() {
  function block_selenagomez_() {
    this.filter_items = bind(this.filter_items, this);
    this.run = bind(this.run, this);
    var css, feed, selenagomez;
    this.selena_gomez = {
      name: "selena gomez",
      instagram_id: 460563723,
      vid_id: "1TsVjvEkc4s"
    };
    css = "#instafeed {\n	display: none;\n}\n.selena-image {\n	height:110%;\n	position: relative;\n	left: -60px;\n	bottom:0;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable celebrity Who\" name=\"selenagomez\">\n	<img class=\"selena-image\" src=\"img/selenagomez.jpg\">\n	<div id=\"instafeed\"></div>\n</div>").appendTo(".drag-zone");
    selenagomez = 460563723;
    feed = new Instafeed({
      get: 'user',
      userId: selenagomez,
      accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d',
      clientId: 'f41df43206564056b252ae8a5cb4019e',
      error: function() {
        return console.log("instagram error");
      },
      success: (function(_this) {
        return function(json) {
          return _this.images = json.data;
        };
      })(this)
    });
    feed.run();
  }

  block_selenagomez_.prototype.run = function() {
    return this.selena_gomez;
  };

  block_selenagomez_.prototype.filter_items = function() {
    var block, i, name, results, temp_list;
    temp_list = $(".draggable.What");
    i = 0;
    results = [];
    while (i < temp_list.length) {
      name = $(temp_list[i]).attr("name");
      block = window["block_" + name];
      if (name === "instagram_competition") {
        block.filter_items();
      }
      results.push(i++);
    }
    return results;
  };

  return block_selenagomez_;

})();
