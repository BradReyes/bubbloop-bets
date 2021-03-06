// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_spotify_ = (function() {
  function block_spotify_() {
    this.run = bind(this.run, this);
    var css;
    css = "[name=spotify] {\n	background-image: url(img/spotify.png);\n	background-size: cover;\n}";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div id=\"spotify\" class=\"drag-wrap draggable source\" name=\"spotify\">\n</div>").appendTo(".drag-zone");
  }

  block_spotify_.prototype.run = function(celeb, cb) {
    var artist;
    artist = celeb.name;
    return $.ajax({
      url: "https://api.spotify.com/v1/search?q=" + artist + "&type=track",
      error: function(jqXHR, textStatus, errorThrown) {
        console.log(jqXHR);
        console.log(textStatus);
        return console.log(errorThrown);
      },
      success: (function(_this) {
        return function(json, textStatus, z) {
          _this.entries = json.tracks.items;
          return cb(_this.entries);
        };
      })(this)
    });
  };

  return block_spotify_;

})();
