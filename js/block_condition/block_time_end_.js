// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_time_end_ = (function() {
  function block_time_end_() {
    this.check_time = bind(this.check_time, this);
    this.run = bind(this.run, this);
    this.get_type = bind(this.get_type, this);
    var $hours, $minutes, $time, css, hours_counter, minutes_counter, morning;
    css = ".arrowUpEnd {\n	position: absolute;\n	width: 10px;\n	top: 10px;\n	left: 10px;\n	font-size: 110%;\n}\n\n.arrowDownEnd {\n	position: absolute;\n	width: 10px;\n	top: 80px;\n	left: 10px;\n	font-size: 110%;\n}\n\ndiv[name='time_end'] {\n	position: relative;\n	font-family: 'Orbitron', sans-serif;\n	font-size: 120%;\n	color: red;\n}\n\n#hoursBlockEnd {\n	position: relative;\n	left: 7px;\n	top: 17px;\n}\n\n#minutesBlockEnd {\n	position: relative;\n	left: 45px;\n	top: 17px;\n}\n\n#timeBlockEnd {\n	position: relative;\n	left: 90px;\n	top: 17px;\n}\n\n#hoursEnd, #minutesEnd, #colonEnd, #timeEnd {\n	position: absolute;\n	top: 5px;\n}\n\n#hoursEnd {\n	left: 4px;\n}\n\n#colonEnd {\n	font-weight: bold;\n	left: 50px;\n	top: 22px;\n}\n\n#minutesEnd {\n	left: 10px;\n}\n\n#timeEnd {\n	position: absolute;\n	left: 5px;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class='drag-wrap draggable When' name='time_end'>\n	<div id=\"hoursBlockEnd\">\n		<div id=\"hoursEnd\">12</div>\n		<i class=\"arrowUpEnd fa fa-arrow-up\"></i>\n		<i class=\"arrowDownEnd fa fa-arrow-down\"></i>\n	</div>\n	<div id=\"colonEnd\">:</div>\n	<div id=\"minutesBlockEnd\">\n		<div id=\"minutesEnd\">00</div>\n		<i class=\"arrowUpEnd fa fa-arrow-up\"></i>\n		<i class=\"arrowDownEnd fa fa-arrow-down\"></i>\n	</div>\n	<div id=\"timeBlockEnd\">\n		<div id=\"timeEnd\">AM</div>\n		<i class=\"arrowUpEnd fa fa-arrow-up\"></i>\n		<i class=\"arrowDownEnd fa fa-arrow-down\"></i>\n	</div>\n</div>").appendTo(".drag-zone");
    $hours = $("#hoursEnd");
    $minutes = $("#minutesEnd");
    $time = $("#timeEnd");
    hours_counter = 12;
    minutes_counter = 0;
    morning = true;
    interact('.arrowUpEnd').on('tap', function(event) {
      var block, hours_text, minutes_text;
      block = $(event.currentTarget).parent()[0].id.toString();
      switch (block) {
        case "hoursBlockEnd":
          hours_counter++;
          if (hours_counter > 12) {
            hours_counter = 1;
          }
          hours_text = hours_counter.toString();
          if (hours_counter <= 9) {
            hours_text = "0" + hours_counter;
          }
          return $hours.text(hours_text);
        case "minutesBlockEnd":
          minutes_counter++;
          if (minutes_counter > 59) {
            minutes_counter = 0;
          }
          minutes_text = minutes_counter.toString();
          if (minutes_counter <= 9) {
            minutes_text = "0" + minutes_counter;
          }
          return $minutes.text(minutes_text);
        case "timeBlockEnd":
          if (morning) {
            $time.text("PM");
            return morning = false;
          } else {
            $time.text("AM");
            return morning = true;
          }
          break;
        default:
          return console.log("Error. File: block_clock.coffee Function: interact(.arrowUp)");
      }
    });
    interact('.arrowDownEnd').on('tap', function(event) {
      var block, hours_text, minutes_text;
      block = $(event.currentTarget).parent()[0].id.toString();
      switch (block) {
        case "hoursBlockEnd":
          hours_counter--;
          if (hours_counter <= 0) {
            hours_counter = 12;
          }
          hours_text = hours_counter.toString();
          if (hours_counter <= 9) {
            hours_text = "0" + hours_counter;
          }
          return $hours.text(hours_text);
        case "minutesBlockEnd":
          minutes_counter--;
          if (minutes_counter < 0) {
            minutes_counter = 59;
          }
          minutes_text = minutes_counter.toString();
          if (minutes_counter <= 9) {
            minutes_text = "0" + minutes_counter;
          }
          return $minutes.text(minutes_text);
        case "timeBlockEnd":
          if (morning) {
            $time.text("PM");
            return morning = false;
          } else {
            $time.text("AM");
            return morning = true;
          }
          break;
        default:
          return console.log("Error. File: block_clock.coffee Function: interact(.arrowUp)");
      }
    });
  }

  block_time_end_.prototype.get_type = function() {
    return "end";
  };

  block_time_end_.prototype.run = function() {
    return this.interval_id = setInterval(this.check_time, 8000);
  };

  block_time_end_.prototype.check_time = function() {
    var clock_hours, clock_minutes, clock_time, time_clock, time_now;
    clock_hours = $("#hoursEnd").text();
    clock_minutes = $("#minutesEnd").text();
    clock_time = $("#timeEnd").text();
    if (clock_time === "PM") {
      clock_hours = parseInt(clock_hours) + 12;
    }
    time_clock = clock_hours + ":" + clock_minutes;
    time_now = moment().format('HH:mm');
    if (time_now === time_clock) {
      return window.location.reload();
    }
  };

  return block_time_end_;

})();
