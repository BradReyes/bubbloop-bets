// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.bubble_section_ = (function() {

  /*
  	Parameters:
  		left
  		top
  		diameter
  		bubble_type
   */
  function bubble_section_(left, top, diameter, bubble_type) {
    var css;
    this.left = left;
    this.top = top;
    this.diameter = diameter;
    this.block_name = bind(this.block_name, this);
    this.revert = bind(this.revert, this);
    this.expand_section = bind(this.expand_section, this);
    this.toggle_bank = bind(this.toggle_bank, this);
    if (window.bubble_counter == null) {
      window.bubble_counter = -1;
    }
    this.counter = ++window.bubble_counter;
    this.bank_visible = false;
    this.block = null;
    this.type = "what";
    if (this.counter === 0) {
      this.type = 'Who';
    }
    if (this.counter === 1) {
      this.type = 'What';
    }
    if (this.counter === 2) {
      this.type = 'When';
    }
    if (this.counter === 3) {
      this.type = 'Where';
    }
    if (this.counter === 4) {
      this.type = 'Why';
    }
    css = ".bubble-section-" + this.counter + " {\n	position: absolute;\n	top: " + this.top + "px;\n	left: " + this.left + "px;\n	width: " + this.diameter + "px;\n	height: " + this.diameter + "px;\n	border: 1px black solid;\n	background: rgba(255, 255, 255,0.8);\n	overflow: hidden;\n}";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div class='steps bubble-sections bubble-section-" + this.counter + " " + this.type + "' role='bubble_section' type='" + bubble_type + "'>\n	<div id='bubble-text-" + this.counter + "'>" + bubble_type + "</div>\n</div>").appendTo(".drop-zone");
    this.drag_zone = new control_drag_zone_(12, 20, 350, 'source', this);
    this.drag_zone.hide();
    $(".bubble-section-" + this.counter).on('tap click', (function(_this) {
      return function() {
        _this.toggle_bank();

        /*
        			bubble section will expand and become a drop zone
        			don't worry about animations yet
         */
        return _this.expand_section();
      };
    })(this));
  }

  bubble_section_.prototype.toggle_bank = function() {
    var $bank, real_height, w_height;
    $bank = $(".drag-selector");
    console.log("Called");
    if (this.bank_visible) {
      w_height = window.innerHeight;
      console.log(w_height);
      $bank.velocity({
        top: w_height + 50
      }, {
        duration: 1000,
        complete: (function(_this) {
          return function() {
            console.log("Got em");
            $(".draggable").css({
              display: "block"
            });
            return $bank.css({
              display: 'none'
            });
          };
        })(this)
      });
    } else {
      w_height = window.innerHeight;
      real_height = w_height - 160;
      $bank.css({
        display: 'block'
      });
      $bank.velocity({
        top: real_height
      }, {
        duration: 1000
      });
    }
    return this.bank_visible = !this.bank_visible;
  };

  bubble_section_.prototype.expand_section = function() {
    var i, items, pos, results, s2;
    this.inner_text = $(".bubble-section-" + this.counter).text();
    $("#expand-navigation").velocity({
      left: 5
    }, {
      duration: 1000
    });
    $("#expand-navigation").bind("tap click", (function(_this) {
      return function() {
        _this.revert(true);
        return _this.toggle_bank();
      };
    })(this));
    $(".bubble-sections:not(.bubble-section-" + this.counter + ")").velocity("fadeOut", {
      duration: 1000
    });
    $("#build_button").velocity("fadeOut", {
      duration: 1000
    });
    $(".bubble-section-" + this.counter).velocity({
      width: 350,
      height: 350,
      top: 20,
      left: 12
    }, {
      duration: 1000,
      complete: (function(_this) {
        return function() {
          if (!_this.drag_zone.is_filled()) {
            $(".bubble-section-" + _this.counter).css({
              visibility: 'hidden'
            });
            return _this.drag_zone.show();
          }
        };
      })(this)
    });
    $("#bubble-text-" + this.counter).velocity("fadeOut", {
      duration: 500,
      complete: (function(_this) {
        return function() {
          $("#bubble-text-" + _this.counter).text("Drag Here");
          return $("#bubble-text-" + _this.counter).velocity("fadeIn", {
            duration: 500
          });
        };
      })(this)
    });
    $(".draggable:not(." + this.type + ")").css({
      display: "none"
    });
    items = $("." + this.type + ".draggable");
    i = 0;
    results = [];
    while (i < items.length) {
      pos = items[i].getBoundingClientRect();
      s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth / 1.2);
      s2 = 1 - Math.abs(s2);
      $(items[i]).css({
        '-webkit-transform': "scale(" + s2 + ")"
      });
      results.push(++i);
    }
    return results;
  };

  bubble_section_.prototype.revert = function(back_button) {
    var i, img_value, items, pos, position_value, repeat_value, results, s2, size_value;
    this.drag_zone.hide();
    console.log("Going back");
    $("#expand-navigation").unbind();
    $("#expand-navigation").velocity({
      left: -110
    }, {
      duration: 500
    });
    if (this.drag_zone.is_filled()) {
      $(".bubble-section-" + this.counter).html($(".dragged-block-" + (this.drag_zone.get_id())).html());
      console.log($(".dragged-block-" + (this.drag_zone.get_id())).html());
      img_value = $(".dragged-block-" + (this.drag_zone.get_id())).css("background-image");
      size_value = $(".dragged-block-" + (this.drag_zone.get_id())).css("background-size");
      repeat_value = $(".dragged-block-" + (this.drag_zone.get_id())).css("background-repeat");
      position_value = $(".dragged-block-" + (this.drag_zone.get_id())).css("background-position");
      $(".bubble-section-" + this.counter).css({
        'background-image': img_value,
        'background-size': size_value,
        'background-position': position_value,
        'background-repeat': repeat_value
      });
    } else {
      $("#bubble-text-" + this.counter).velocity("fadeOut", {
        duration: 500,
        complete: (function(_this) {
          return function() {
            $("#bubble-text-" + _this.counter).text(_this.inner_text);
            return $("#bubble-text-" + _this.counter).velocity("fadeIn", {
              duration: 500
            });
          };
        })(this)
      });
    }
    $(".dragged-block-" + (this.drag_zone.get_id())).css({
      display: 'none'
    });
    $(".bubble-section-" + this.counter).css({
      visibility: 'visible'
    });
    $(".bubble-section-" + this.counter).velocity({
      width: this.diameter,
      height: this.diameter,
      top: this.top,
      left: this.left
    }, {
      duration: 1000
    });
    $(".bubble-sections:not(.bubble-section-" + this.counter + ")").velocity("fadeIn", {
      duration: 1000
    });
    $("#build_button").velocity("fadeIn", {
      duration: 1000
    });
    items = $(".draggable");
    i = 0;
    results = [];
    while (i < items.length) {
      pos = items[i].getBoundingClientRect();
      s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth / 1.2);
      s2 = 1 - Math.abs(s2);
      $(items[i]).css({
        '-webkit-transform': "scale(" + s2 + ")"
      });
      results.push(++i);
    }
    return results;
  };

  bubble_section_.prototype.block_name = function() {
    return this.drag_zone.get_name();
  };

  return bubble_section_;

})();
