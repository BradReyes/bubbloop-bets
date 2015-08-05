// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_instagram_ = (function() {
  function block_instagram_() {
    this.loop_done = bind(this.loop_done, this);
    this.run = bind(this.run, this);
    var css;
    css = "[name=instagram] {\n	background-image: url(img/instagram.png);\n	background-size: cover;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable source\" name=\"instagram\">\n</div>\n<div id=\"instafeed\"></div>").appendTo(".drag-zone");
  }

  block_instagram_.prototype.run = function(celeb, cb) {
    var audio;
    audio = new Audio("sound/" + celeb.name + ".mp3");
    audio.play();
    this.uploaded_count = 0;
    $("<img src='img/load2.gif' style='position:absolute;top:10px;left:10px;width:350px;height:auto;z-index:1004;'>").appendTo($("body"));
    $("<div id='compilation-animation' style='position:absolute;top:200px;left:70px;font-size:230%;color:white;z-index:1005;'>COMPILING</div>").appendTo($("body"));
    $("<div id='progress-animation' style='position:absolute;top:250px;left:80px;font-size:120%;color:white;z-index:1005;'>0 PICTURES LOADED</div>").appendTo($("body"));
    $("#new-button").remove();
    this.current_interval = 0;
    setInterval((function(_this) {
      return function() {
        var cur, dots, i, ref;
        _this.current_interval++;
        if (_this.current_interval > 3) {
          _this.current_interval = 0;
        }
        dots = "";
        for (cur = i = 0, ref = _this.current_interval; i < ref; cur = i += 1) {
          dots += ".";
        }
        return $("#compilation-animation").text("COMPILING" + dots);
      };
    })(this), 500);
    this.all_posts = [];
    this.feed = new Instafeed({
      get: 'user',
      userId: celeb.instagram_id,
      accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d',
      clientId: 'f41df43206564056b252ae8a5cb4019e',
      limit: 60,
      error: function() {
        return console.log("instagram error");
      },
      success: (function(_this) {
        return function(json) {
          var cur, i, len, list;
          list = json.data;
          for (i = 0, len = list.length; i < len; i++) {
            cur = list[i];
            _this.uploaded_count++;
            _this.all_posts.push(cur);
          }
          $("#progress-animation").text(_this.uploaded_count + " PICTURES LOADED");
          return cb(_this.all_posts);
        };
      })(this)
    });
    return this.feed.run();
  };

  block_instagram_.prototype.loop_done = function(cb) {
    if (this.feed.hasNext()) {
      return this.feed.next();
    } else {
      return cb(this.all_posts);
    }
  };

  return block_instagram_;

})();
