// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_instagram_competition_ = (function() {
  function block_instagram_competition_() {
    this.filter_items = bind(this.filter_items, this);
    this.get_images = bind(this.get_images, this);
    this.check_filters = bind(this.check_filters, this);
    this.run = bind(this.run, this);
    this.get_type = bind(this.get_type, this);
    var css;
    css = "		";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable celeb What block_instagram_\" name=\"instagram_competition\">\n	<img style='width:100%;height:auto;position:absolute;top:16%;left:0%;' src='http://d13zeczpqm2715.cloudfront.net/wp-content/uploads/2015/06/instagram-logo-vector-image.png'>\n</div>").appendTo(".drag-zone");
  }

  block_instagram_competition_.prototype.get_type = function() {
    return "action";
  };

  block_instagram_competition_.prototype.run = function(who, where, action, helpers) {
    if ($.inArray("me", who) !== -1) {
      alert("We don't have your instagram account");
      return;
    }
    this.combined_posts = [];
    return async.forEachOfSeries(who, (function(_this) {
      return function(element, i, cb) {
        var cur_id;
        cur_id = element.instagram_id;
        return _this.get_images(function(list) {
          var item, l, len;
          for (l = 0, len = list.length; l < len; l++) {
            item = list[l];
            if (_this.check_filters(helpers, item)) {
              _this.combined_posts.push(item);
            }
          }
          return cb();
        }, cur_id);
      };
    })(this), (function(_this) {
      return function(err) {
        return action(_this.combined_posts);
      };
    })(this));
  };

  block_instagram_competition_.prototype.check_filters = function(helpers, item) {
    var helper, l, len;
    if (helpers.length === 0) {
      return true;
    }
    for (l = 0, len = helpers.length; l < len; l++) {
      helper = helpers[l];
      if (helper.run(item) === true) {
        return true;
      }
    }
    return false;
  };

  block_instagram_competition_.prototype.get_images = function(cb, user_id) {
    var all_posts, feed, given_id;
    given_id = user_id;
    all_posts = [];
    feed = new Instafeed({
      get: 'user',
      userId: given_id,
      accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d',
      clientId: 'f41df43206564056b252ae8a5cb4019e',
      limit: 60,
      error: function() {
        return alert("instagram error");
      },
      success: (function(_this) {
        return function(json) {
          var cur, l, len, list;
          list = json.data;
          for (l = 0, len = list.length; l < len; l++) {
            cur = list[l];
            all_posts.push(cur);
          }
          return cb(all_posts);
        };
      })(this)
    });
    return feed.run();
  };

  block_instagram_competition_.prototype.filter_items = function() {
    var i, insta_id, j, k, name, results, ret_type, temp_block, temp_list, what_block, what_list, why_block, why_list;
    temp_list = $(".draggable.Who");
    what_list = $(".draggable.What");
    why_list = $(".draggable.Why");
    i = 0;
    while (i < temp_list.length) {
      name = $(temp_list[i]).attr("name");
      temp_block = window["block_" + name];
      insta_id = temp_block.run();
      insta_id = insta_id.instagram_id;
      if (insta_id === null) {
        temp_list[i].parentNode.removeChild(temp_list[i]);
      }
      i++;
    }
    j = 0;
    while (j < what_list.length) {
      name = $(what_list[j]).attr("name");
      what_block = window["block_" + name];
      ret_type = what_block.get_type();
      console.log(ret_type);
      if ((what_block.get_type() === "action") && (name !== "instagram_competition")) {
        what_list[j].parentNode.removeChild(what_list[j]);
      }
      j++;
    }
    k = 0;
    results = [];
    while (k < why_list.length) {
      name = $(why_list[k]).attr("name");
      why_block = window["block_" + name];
      if (!(name === "display_image" || name === "gmail")) {
        console.log(why_list[k]);
        console.log(why_list[k].parentNode);
        console.log($(why_list[k]).children());
        why_list[k].parentNode.removeChild(why_list[k]);
      }
      results.push(k++);
    }
    return results;
  };

  return block_instagram_competition_;

})();
