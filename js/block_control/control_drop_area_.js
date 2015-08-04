// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.control_drop_area_ = (function() {
  function control_drop_area_() {
    this.show_winner = bind(this.show_winner, this);
    this.begin_competition = bind(this.begin_competition, this);
    this.begin_animation = bind(this.begin_animation, this);
    this.split_zones = bind(this.split_zones, this);
    this.step_animation = bind(this.step_animation, this);
    this.add_bubble_sections = bind(this.add_bubble_sections, this);
    var css;
    css = ".drop_area {\n	position: relative;\n}";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div id='current-step' class='text'></div>\n<div class='drop_area' role='drop_area'></div>").appendTo($("body"));
    this.add_bubble_sections();
  }

  control_drop_area_.prototype.add_bubble_sections = function() {
    var bubble_size, height_adjustment;
    bubble_size = 130;
    height_adjustment = 100;
    new bubble_section_(50, 5 + height_adjustment, bubble_size, 'Who');
    new bubble_section_(200, 5 + height_adjustment, bubble_size, "What");
    new bubble_section_(5, 150 + height_adjustment, bubble_size, "When");
    new bubble_section_(240, 150 + height_adjustment, bubble_size, "Where");
    return new bubble_section_(125, 250 + height_adjustment, bubble_size, "Why");
  };

  control_drop_area_.prototype.step_animation = function(new_text) {
    var $next, duration;
    duration = 200;
    $next = $(".step-by-step");
    return $next.velocity({
      left: '-400'
    }, {
      duration: duration,
      complete: (function(_this) {
        return function() {
          $next.text(new_text);
          return $next.velocity({
            left: '5'
          }, {
            duration: duration
          });
        };
      })(this)
    });
  };

  control_drop_area_.prototype.split_zones = function(original_drag_zone, new_drag_zone) {};

  control_drop_area_.prototype.expand = function(block_name) {};

  control_drop_area_.prototype.create_button = function() {
    var $blacken, $new_div;
    $blacken = $("<div id='blackened-background-button'></div>").css({
      'z-index': '500',
      'opacity': '0.5',
      'background-color': 'black',
      width: '100%',
      height: '100%',
      position: 'absolute',
      left: '0px',
      top: '0px'
    });
    $("body").prepend($blacken);
    $new_div = $("<div id=\"new-button\">\n	<p style='position:absolute;font-size: 25px;left:17px;top:5px;' >RUN!</p>\n</div>");
    $new_div.css({
      borderRadius: 100,
      width: 90,
      height: 90,
      position: 'absolute',
      top: 140,
      left: 140,
      zIndex: 1000,
      backgroundColor: 'white'
    });
    $("body").prepend($new_div);
    $new_div.addClass('can--drop');
    return $new_div.bind('tap click', (function(_this) {
      return function() {
        return _this.run();
      };
    })(this));
  };

  control_drop_area_.prototype.begin_animation = function() {
    $("#new-button").remove();
    $("#blackened-background-button").remove();
    $(".drop-zone").remove();
    $("<div id='white-background-geocaching'></div>").prependTo($("body"));
    $("#white-background-geocaching").css({
      width: '100%',
      height: '100%',
      'z-index': '1500',
      'background-image': 'url("img/earth.gif")',
      'background-size': '70% auto',
      'background-repeat': 'no-repeat',
      'background-position': 'center 30%'
    });
    $("<h4 id='geocaching-message-coordinate'>##</h4>").prependTo($("body"));
    $("</br><h1 id='geocaching-message'>Your Coordinates</h1>").prependTo($("body"));
    $("#geocaching-message").css({
      'text-align': 'center',
      'color': 'white'
    });
    return $("#geocaching-message-coordinate").css({
      'text-align': 'center',
      'color': 'white'
    });
  };

  control_drop_area_.prototype.begin_competition = function(competitors) {
    var css;
    $("#matchup-container").remove();
    $("#new-button").remove();
    $("#blackened-background-button").remove();
    $(".drop-zone").css("display", "none");
    $(".drag-zone-background").remove();
    $(".drag-zone").css("display", "none");
    $("#current-step").remove();
    $(".delete-p-tags").remove();
    css = ".instagram-matchup-screen {\n	/*width: 33%;*/\n	display: inline;\n	text-align: center;\n\n}\n\n.profile-pic-matchup {\n	width: 150px;\n	height: auto;\n	border-radius: 200px;\n}\n\n.vs-text {\n	height: 300px;\n	padding: 30px;\n	font-size: 150%;\n	color: white;\n}\n\n.counter-matchup {\n	display: block;\n	color: white;\n}\n\n.not-main-pic {\n	width: 50px;\n	height: auto;\n	border-radius: 200px;\n}\n";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div id='matchup-container'>\n</div>").appendTo($("body"));
    $("<div class='instagram-matchup-screen profile-pic-matchup' style='position:absolute;top:170px;left:10px;'>\n	<img class='profile-pic-matchup' src='" + competitors.first_val[1].images.standard_resolution.url + "'>\n	<img class='not-main-pic' style='position:absolute;top:0px;left:0px;' src='" + competitors.first_val[1].user.profile_picture + "'>\n	<p id=\"instagram-matchup-counter-1\" class='counter-matchup'> TEST HERE 1</p>\n</div>").appendTo($("#matchup-container"));
    $("<div class='instagram-matchup-screen vs-text' style='position:absolute;top:200px;left:140px;'>\n	VS\n</div>").appendTo($("#matchup-container"));
    $("<div class='instagram-matchup-screen profile-pic-matchup' style='position:absolute;top:170px;left:215px;'>\n	<img class='profile-pic-matchup' src='" + competitors.second_val[1].images.standard_resolution.url + "'>\n	<img class='not-main-pic' style='position:absolute;top:0px;right:0px;' src='" + competitors.second_val[1].user.profile_picture + "'>\n	<p id=\"instagram-matchup-counter-2\" class='counter-matchup'> TEST HERE 2</p>\n</div>").appendTo($("#matchup-container"));
    $("body").css('text-align', 'center');
    return $("<p class='delete-p-tags' style='margin:0px;margin-top:450px;font-size:200%;color:white;'> GOAL </p>\n<p id='put-goal-here' class='delete-p-tags' style='margin:0px;font-size:200%;color:white;'> #### </p>").appendTo($("body"));
  };

  control_drop_area_.prototype.show_winner = function(winner, player1) {
    var $container, $info_container, $info_container2;
    $(".delete-p-tags").remove();
    $container = $("#matchup-container");
    $container.html(" ");
    $container.css("text-align", "center");
    if (player1) {
      $("<img id='actual-pic-animation' src='" + winner.images.standard_resolution.url + "' \nstyle='width:150px;height:auto;border-radius:200px;position:absolute;top:170px;left:10px;'>").appendTo($container);
      $info_container = $("<div id='info-matchup-container'></div>");
      $info_container2 = $("<div id='info-matchup-container2'></div>");
      $info_container.appendTo($container);
      $info_container.css({
        "display": 'flex',
        'justify-content': 'center',
        'align-items': 'center'
      });
      $info_container2.appendTo($container);
      $("<img id='profile-pic-animation' src='" + winner.user.profile_picture + "' \nstyle='position:absolute;top:170px;left:10px;\nwidth:50px;height:auto;border-radius:200px;'>").appendTo($info_container);
      $("<p id='results-winnerinfo-1' \nstyle='position:absolute;top:365px;left:120px;\nfont-size:200%;margin:20px;margin-left:10px;color:white;\n'> " + winner.user.username + " </p>").appendTo($info_container);
      $("<p id='results-winnerinfo-2' style='display:block;font-size:200%;color:white;margin-top:440px;padding:0px;'\n> is the WINNER! </p>").appendTo($info_container2);

      /* Animations here */
      $("#results-winnerinfo-1").velocity("fadeIn", {
        'duration': 2500
      });
      $("#results-winnerinfo-2").velocity("fadeIn", {
        'duration': 3000
      });
      $("#actual-pic-animation").velocity({
        top: 80,
        left: 40,
        width: 300,
        height: 300
      });
      return $("#profile-pic-animation").velocity({
        top: 390,
        left: 70
      });
    } else {
      $("<img id='actual-pic-animation' src='" + winner.images.standard_resolution.url + "' \nstyle='width:150px;height:auto;border-radius:200px;position:absolute;top:170px;left:215px;'>").appendTo($container);
      $info_container = $("<div id='info-matchup-container'></div>");
      $info_container2 = $("<div id='info-matchup-container2'></div>");
      $info_container.appendTo($container);
      $info_container.css({
        "display": 'flex',
        'justify-content': 'center',
        'align-items': 'center'
      });
      $info_container2.appendTo($container);
      $("<img id='profile-pic-animation' src='" + winner.user.profile_picture + "' \nstyle='position:absolute;top:170px;left:315px;\nwidth:50px;height:auto;border-radius:200px;'>").appendTo($info_container);
      $("<p id='results-winnerinfo-1' \nstyle='position:absolute;top:365px;left:120px;\nfont-size:200%;margin:20px;margin-left:10px;color:white;\n'> " + winner.user.username + " </p>").appendTo($info_container);
      $("<p id='results-winnerinfo-2' style='display:block;font-size:200%;color:white;margin-top:440px;padding:0px;'\n> is the WINNER! </p>").appendTo($info_container2);

      /* Animations here */
      $("#results-winnerinfo-1").velocity("fadeIn", {
        'duration': 2500
      });
      $("#results-winnerinfo-2").velocity("fadeIn", {
        'duration': 3000
      });
      $("#actual-pic-animation").velocity({
        top: 80,
        left: 40,
        width: 300,
        height: 300
      });
      return $("#profile-pic-animation").velocity({
        top: 390,
        left: 70
      });
    }
  };

  control_drop_area_.prototype.run = function() {
    var competition;
    $(".step-by-step").remove();
    competition = (function(_this) {
      return function() {
        console.log("Got in competition");
        return _this.location.run(function(competitors) {
          console.log(competitors);
          _this.begin_competition(competitors);
          return _this.destination.run(competitors, function(winner, player1) {
            console.log("got in winner");
            if (winner != null) {
              clearInterval(_this.stop_interval);
              console.log("There's a winner!");
              return _this.show_winner(winner, player1);
            }
          });
        });
      };
    })(this);
    competition();
    return this.stop_interval = setInterval(competition, 7000);
  };

  return control_drop_area_;

})();
