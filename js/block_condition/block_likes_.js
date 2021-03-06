// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_likes_ = (function() {
  function block_likes_() {
    this.filter_items = bind(this.filter_items, this);
    this.run = bind(this.run, this);
    this.get_type = bind(this.get_type, this);
    this.expand = bind(this.expand, this);
    this.blacken_background = bind(this.blacken_background, this);
    var css;
    css = ".likes-input{\n	position: absolute;\n	top: 55%;\n	width: 80%;\n	left: 6%;\n	text-align: center;\n	font-size: 12px;\n}\n\ninput[type='text'],\ninput[type='number'],\ntextarea {\n	font-size: 16px;\n}\n\n.likes-filter-text {\n	position: absolute;\n	top: -25px;\n	left: 20px;\n	font-size: 150%;\n	font-weight: bold;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable instagram_filter What\" name=\"likes\">\n	<p class='likes-filter-text'>> LIKES</p>\n	<input class=\"likes-input\" type=\"text\" value=\"0\">\n</div>").appendTo(".drag-zone");
    interact(".likes-input").on('tap', (function(_this) {
      return function(event) {
        event.preventDefault();
        $(".likes-input").focus();
        return _this.expand(".likes-input");
      };
    })(this));
  }

  block_likes_.prototype.blacken_background = function() {
    var $blacken;
    $blacken = $("<div id='blacken-input'>");
    $blacken.css({
      zIndex: 500,
      backgroundColor: 'rgba(0,0,0,0.5)',
      width: '100%',
      height: '100%',
      position: 'absolute',
      left: 0,
      top: 0
    });
    return $("body").prepend($blacken);
  };

  block_likes_.prototype.expand = function(selector) {
    var $popup_input, actual, actual_height, box_width, height, left, original_height, original_width, position, scale, scaled, str_length, value, width;
    this.blacken_background();
    height = document.documentElement.clientHeight;
    width = document.documentElement.clientWidth;
    box_width = width / 2;
    left = width / 2 - box_width / 2;
    value = $(selector).val();
    $popup_input = $("<input id='popup-input' type='text'>");
    $popup_input.val(value);
    $popup_input.appendTo($("body"));
    str_length = $popup_input.val().length * 2;
    $popup_input.focus();
    $popup_input[0].setSelectionRange(str_length, str_length);
    position = $(selector).offset();
    actual = $(selector)[0].getBoundingClientRect().width;
    actual_height = $(selector)[0].getBoundingClientRect().height;
    scaled = $(selector)[0].offsetWidth;
    scale = actual / scaled;
    original_width = $(selector).innerWidth();
    original_height = $(selector).innerHeight();
    $("#popup-input").css({
      zIndex: 600,
      position: "fixed",
      left: position.left,
      top: position.top,
      fontSize: 16,
      textAlign: 'center',
      width: original_width * scale + 1,
      height: actual_height
    });
    $popup_input.velocity({
      width: box_width,
      height: original_height,
      top: height / 2,
      left: left
    });
    $("#popup-input").on('keyup', (function(_this) {
      return function(event) {
        var new_value;
        if (event.which === 13) {
          return $("#popup-input").blur();
        } else {
          new_value = $("#popup-input").val();
          return $(selector).val(new_value);
        }
      };
    })(this));
    return $("#popup-input").blur((function(_this) {
      return function() {
        $("#blacken-input").remove();
        return $("#popup-input").remove();
      };
    })(this));
  };

  block_likes_.prototype.get_type = function() {
    return "helper";
  };

  block_likes_.prototype.run = function(item) {
    var likes;
    if (this.num_likes == null) {
      console.log($(".likes-input").val());
      this.num_likes = parseInt($(".likes-input").val());
    }
    likes = item.likes.count;
    if (likes >= this.num_likes) {
      return true;
    }
    return false;
  };

  block_likes_.prototype.filter_items = function() {
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

  return block_likes_;

})();
