// Generated by CoffeeScript 1.9.3
$(function() {
  var c, cb, commands, cr, h, items, onScroll, put_text_in_block, startPos, w;
  window.counter = 0;
  window.block_picture = new block_picture_();
  window.block_geocaching = new block_geocaching_();
  window.block_instagram_competition = new block_instagram_competition_();
  window.block_hoovertower = new block_hoovertower_();
  window.block_my_location = new block_my_location_();
  window.block_pizza = new block_pizza_();
  window.control = new control_drop_area_(function() {
    return console.log("DONE");
  });
  items = document.querySelectorAll(".drag-wrap");
  h = window.innerHeight;
  w = window.innerWidth;
  c = items[Math.round(items.length / 2)];
  cr = c.getBoundingClientRect();
  onScroll = (function(_this) {
    return function() {
      var i, pos, s2;
      i = 0;
      while (i < items.length) {
        pos = items[i].getBoundingClientRect();
        s2 = (pos.left + pos.width / 2 - (w / 2)) / (w / 1.2);
        s2 = 1 - Math.abs(s2);
        $(items[i]).css({
          '-webkit-transform': "scale(" + s2 + ")"
        });
        ++i;
      }
    };
  })(this);
  onScroll(cr.left - (w / 2) + cr.width / 2, cr.top - (h / 2) + cr.height / 2);
  interact('.drag-zone').draggable({
    inertia: true,
    restrict: {
      restriction: 'body',
      endOnly: true,
      elementRect: {
        left: 0.80,
        right: 0.20
      }
    },
    onstart: function(event) {},
    onmove: (function(_this) {
      return function(event) {
        var $target, x;
        $target = $(event.target);
        x = (parseFloat($target.attr('data-x')) || 0) + event.dx;
        $target.css({
          '-webkit-transform': "translate(" + x + "px)"
        });
        $target.attr('data-x', x);
        items = document.querySelectorAll(".drag-wrap");
        return onScroll();
      };
    })(this)
  });
  startPos = null;
  interact('.draggable').draggable({
    inertia: true,
    restrict: {
      restriction: 'body',
      endOnly: true,
      elementRect: {
        top: 0,
        left: 0,
        bottom: 1,
        right: 1
      }
    },
    axis: 'xy',
    snap: {
      targets: [startPos],
      relativePoints: [
        {
          x: 0.5,
          y: 0.5
        }
      ],
      range: 100,
      endOnly: true
    },
    onstart: function(event) {
      var rect;
      rect = interact.getElementRect(event.target);
      startPos = {
        x: rect.left + rect.width / 2,
        y: rect.top + rect.height / 2
      };
      return event.interactable.draggable({
        snap: {
          targets: [startPos],
          range: 200
        }
      });
    },
    onmove: function(event) {
      var $target, x, y;
      $target = $(event.target);
      x = (parseFloat($target.attr('data-x')) || 0) + event.dx;
      y = (parseFloat($target.attr('data-y')) || 0) + event.dy;
      $target.css({
        '-webkit-transform': "translate(" + x + "px, " + y + "px)"
      });
      $target.attr('data-x', x);
      $target.attr('data-y', y);
      return $target.addClass('getting--dragged');
    },
    onend: function(event) {
      var $target;
      $target = $(event.target);
      return $target.removeClass('getting--dragged');
    }
  });
  cb = (function(_this) {
    return function() {
      return console.log("RUN");
    };
  })(this);
  $("#button_run").click((function(_this) {
    return function() {
      return control.run(cb);
    };
  })(this));
  $("#button_reset").click((function(_this) {
    return function() {
      return location.reload();
    };
  })(this));
  put_text_in_block = function(text, block_name) {
    return $("#" + block_name).val(text);
  };
  commands = {
    'put *text in :block_name block': put_text_in_block,
    'run': control.run
  };
  annyang.addCommands(commands);
  return annyang.start({
    continuous: true
  });
});
