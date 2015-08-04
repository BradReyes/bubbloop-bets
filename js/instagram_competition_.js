// Generated by CoffeeScript 1.9.3

/*
instagram_competition_ class
----------------------------
parameters:
1) username1: string
2) username2: string
3) time: number (in minutes)

Competitor object:
id: userid
image: imageObj
 */
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.instagram_competition_ = (function() {

  /* Constructor */
  function instagram_competition_(username1, username2, time) {
    this.username1 = username1;
    this.username2 = username2;
    this.time = time;
    this.get_closest_user = bind(this.get_closest_user, this);
    this.get_media = bind(this.get_media, this);
    this.find_feeds = bind(this.find_feeds, this);
    this.run_feeds = bind(this.run_feeds, this);
    console.log(this.username1 + "\n" + this.username2 + "\n" + this.time);
    this.first_time_through = true;
    this.run_feeds((function(_this) {
      return function(competitors) {
        console.log("FINSIHED THE FUCKING LOADING FEEDS");
        console.log(_this.competitors[0].image.likes.count);
        console.log(_this.competitors[1].image.likes.count);
        return console.log("DONE");
      };
    })(this));
    setInterval(this.run_feeds, 7000, (function(_this) {
      return function() {
        console.log("seconbd times a charm");
        console.log(_this.competitors[0].image.likes.count);
        console.log(_this.competitors[1].image.likes.count);
        return console.log("DONE");
      };
    })(this));
  }


  /* Public Methods */


  /* Private Methods */


  /*
  		Takes in a callback that makes sure
   */

  instagram_competition_.prototype.run_feeds = function(cb) {
    if (!this.first_time_through) {
      this.get_media(this.competitors[0].image.id, cb, true);
      return this.get_media(this.competitors[1].image.id, cb, false);
    } else {
      return this.get_closest_user(this.username1, (function(_this) {
        return function(id) {
          _this.player1_id = id;
          return _this.get_closest_user(_this.username2, function(id) {
            _this.player2_id = id;
            return _this.find_feeds(_this.player1_id, _this.player2_id, cb);
          });
        };
      })(this));
    }
  };

  instagram_competition_.prototype.find_feeds = function(first_player, second_player, cb) {
    var both_done, first_feed;
    console.log(first_player);
    console.log(second_player);
    both_done = false;
    this.competitors = [
      {
        id: first_player,
        image: null
      }, {
        id: second_player,
        image: null
      }
    ];
    first_feed = new Instafeed({
      get: 'user',
      userId: parseInt(first_player),
      accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d',
      clientId: 'f41df43206564056b252ae8a5cb4019e',
      limit: 2,
      error: function() {
        return alert("instagram error");
      },
      success: (function(_this) {
        return function(json) {
          var image_1, second_feed;
          image_1 = json.data[0];
          _this.competitors[0].image = image_1;
          second_feed = new Instafeed({
            get: 'user',
            userId: parseInt(second_player),
            accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d',
            clientId: 'f41df43206564056b252ae8a5cb4019e',
            limit: 2,
            error: function() {
              return alert("instagram error");
            },
            success: function(json) {
              var image_2;
              image_2 = json.data[0];
              _this.competitors[1].image = image_2;
              console.log(_this.competitors);
              return _this.first_time_through = false;
            }
          });
          return second_feed.run();
        };
      })(this)
    });
    return first_feed.run();
  };

  instagram_competition_.prototype.get_media = function(media_id, cb, player1) {
    var access_token, get_url;
    access_token = "2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d";
    get_url = "https://api.instagram.com/v1/media/" + media_id + "?access_token=" + access_token;
    return $.ajax({
      url: get_url,
      dataType: "jsonp",
      success: (function(_this) {
        return function(data) {
          if (player1) {
            _this.competitors[0].image = data.data;
          } else {
            _this.competitors[1].image = data.data;
          }
          if (_this.both_medias_finished) {
            return cb(_this.competitors);
          } else {
            return _this.both_medias_finished = true;
          }
        };
      })(this)
    });
  };

  instagram_competition_.prototype.get_closest_user = function(username, cb) {
    var access_token, encoded_username, get_url;
    encoded_username = encodeURIComponent(username);
    access_token = "2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d";
    get_url = "https://api.instagram.com/v1/users/search?q=" + encoded_username + "&access_token=" + access_token;
    return $.ajax({
      url: get_url,
      dataType: "jsonp",
      success: (function(_this) {
        return function(data) {
          var i, len, matching_id, user, user_list;
          user_list = data.data;
          matching_id = user_list[0].id;
          for (i = 0, len = user_list.length; i < len; i++) {
            user = user_list[i];
            if (user.username === username) {
              matching_id = user.id;
              break;
            }
          }
          console.log("GOT IN SUCCESSSSSSSS");
          console.log(matching_id);
          return cb(matching_id);
        };
      })(this)
    });
  };

  return instagram_competition_;

})();