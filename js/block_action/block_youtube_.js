// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_youtube_ = (function() {
  function block_youtube_() {
    this.filter_items = bind(this.filter_items, this);
    this.search = bind(this.search, this);
    this.run = bind(this.run, this);
    var css;
    css = "#youtube_pic{\n	position: absolute;\n	left: 20px;\n	top: 25px;\n	width: 100px;\n	height: 100px;\n}\n\n#youtube_player {\n	position: absolute;\n	top: 0px;\n	left: -144px;\n}\n";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable Why\" name=\"youtube\">\n	<div id=\"youtube_player\"></div>\n	<img id=\"youtube_pic\" src=\"img/youtube-logo.png\">\n</div>").appendTo(".drag-zone");
  }

  block_youtube_.prototype.run = function(people) {
    var celeb, complete_query, k, len;
    if (people.length <= 0) {
      alert("Need someone to search");
      return;
    }
    complete_query = "";
    for (k = 0, len = people.length; k < len; k++) {
      celeb = people[k];
      complete_query += celeb.name + " ";
    }
    return this.search(encodeURIComponent(complete_query), (function(_this) {
      return function(videos) {
        var $youtube, video;
        video = videos[0];
        $("body").html(" ");
        $youtube = $("<iframe title='Youtube' width='100%' height='100%'\nsrc='" + video.source + "' frameborder='0' allowfullscreen>\n</iframe>");
        return $youtube.appendTo($("body"));
      };
    })(this));
  };

  block_youtube_.prototype.search = function(query, cb) {
    var YT_API_KEY, YT_EMBED_URL, YT_URL, getURL;
    YT_URL = 'https://www.googleapis.com/youtube/v3/search';
    YT_API_KEY = 'AIzaSyDDP01Gnj3-wfoqM59xQz6pryJQhmYWCt8';
    YT_EMBED_URL = 'http://www.youtube.com/embed/';
    getURL = YT_URL + "?key=" + YT_API_KEY + "&q=" + query + "&part=snippet&type=value";
    return $.ajax({
      method: "GET",
      url: getURL
    }).done((function(_this) {
      return function(body, response, error) {
        var video_objects, videos;
        videos = body.items;
        console.log(videos);
        video_objects = [];
        videos.forEach(function(cur) {
          if (cur.id.videoId != null) {
            return video_objects.push({
              'title': cur.snippet.title,
              'source': YT_EMBED_URL + cur.id.videoId + "?autoplay=1"
            });
          }
        });
        return cb(video_objects);
      };
    })(this));
  };

  block_youtube_.prototype.filter_items = function() {
    var $cur, i, j, name, results, what_list, who_list;
    what_list = $(".draggable.What");
    who_list = $(".draggable.Who");
    i = 0;
    while (i < what_list.length) {
      name = $(what_list[i]).attr("name");
      $cur = $("div[name='" + name + "']");
      $cur.remove();
      i++;
    }
    j = 0;
    results = [];
    while (j < who_list.length) {
      name = $(who_list[j]).attr("name");
      $cur = $("div[name='" + name + "']");
      if (!($cur.hasClass("celebrity"))) {
        $cur.remove();
      }
      results.push(j++);
    }
    return results;
  };

  return block_youtube_;

})();
