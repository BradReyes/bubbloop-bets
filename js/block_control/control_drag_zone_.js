// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.control_drag_zone_ = (function() {
  function control_drag_zone_(left, top, diameter, bubble_type, section) {
    this.get_name = bind(this.get_name, this);
    this.is_filled = bind(this.is_filled, this);
    this.get_id = bind(this.get_id, this);
    this.get_selector = bind(this.get_selector, this);
    this.show = bind(this.show, this);
    this.hide = bind(this.hide, this);
    this.run = bind(this.run, this);
    var append_to_this, css, items, onScroll;
    this.counter_id = window.counter;
    window.counter = this.counter_id + 1;
    this.left = left;
    this.top = top;
    this.diameter = diameter;
    this.bubble_type = bubble_type;
    this.section = section;
    this.filled = false;
    this.block_name = null;
    css = ".droppable-" + this.counter_id + " {\n	position: absolute;\n	top: " + top + "px;\n	left: " + left + "px;\n	width: " + diameter + "px;\n	height: " + diameter + "px;\n	border: 1px black solid;\n	background: rgba(255, 255, 255, 0.8);\n}";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("." + this.bubble_type).css({
      opacity: 1
    });
    append_to_this = null;
    if (typeof $target !== "undefined" && $target !== null) {
      append_to_this = $target;
    } else {
      append_to_this = '.drop-zone';
    }
    $("<div id='celeb-drop-zone' class='droppable steps droppable-" + this.counter_id + "' role='condition'>\n	Drag Here\n</div>").appendTo(".drop-zone");
    items = $(".drag-wrap");
    onScroll = (function(_this) {
      return function() {
        var i, pos, s2;
        i = 0;
        while (i < items.length) {
          pos = items[i].getBoundingClientRect();
          s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth / 1.2);
          s2 = 1 - Math.abs(s2);
          $(items[i]).css({
            '-webkit-transform': "scale(" + s2 + ")"
          });
          ++i;
        }
      };
    })(this);
    interact(".droppable-" + this.counter_id).dropzone({
      accept: '.draggable',
      overlap: .1,
      ondropactivate: function(event) {
        var $target;
        $target = $(event.target);
        return $target.addClass('can--drop');
      },
      ondragenter: function(event) {
        var $draggableElement, dropCenter, dropRect, dropzoneElement;
        $draggableElement = $(event.relatedTarget);
        dropzoneElement = event.target;
        dropRect = interact.getElementRect(dropzoneElement);
        dropCenter = {
          x: dropRect.left + dropRect.width / 2,
          y: dropRect.top + dropRect.height / 2
        };
        event.draggable.draggable({
          snap: {
            targets: [dropCenter]
          }
        });
        dropzoneElement.classList.add('can--catch');
        return $draggableElement.addClass('drop--me');
      },
      ondragleave: function(event) {
        var $relatedTarget, $target;
        $target = $(event.target);
        $relatedTarget = $(event.relatedTarget);
        $target.removeClass('can--catch');
        $relatedTarget.removeClass('caught--it');
        return $relatedTarget.removeClass('drop--me');
      },
      ondrop: (function(_this) {
        return function(event) {
          var $clone, $related_target, $target, block_name, x, y;
          $target = $(event.target);
          $related_target = $(event.relatedTarget);
          block_name = $related_target.attr("name");
          _this.block = window["block_" + block_name];
          _this.filled = true;
          _this.block_name = block_name;
          if ($related_target.hasClass('drag-wrap')) {
            $clone = $related_target.detach();
            $clone.removeClass('drag-wrap');
            $clone.removeClass('getting--dragged');
            $clone.removeClass('draggable');
            $clone.addClass('not-draggable');
            $clone.appendTo('.drop-zone');
            $clone.removeClass(_this.bubble_type);
            $clone.addClass("dragged-block-" + _this.counter_id);
            console.log("dragged-block-" + _this.counter_id);
            x = $target.position().left + 10;
            y = $target.position().top + 10;
            $clone.attr('data-x', x);
            $clone.attr('data-y', y);
            items = $(".drag-wrap");
            onScroll();
            _this.section.revert($clone);
            return _this.section.toggle_bank();
          }
        };
      })(this),
      ondropdeactivate: function(event) {
        var $target;
        $target = $(event.target);
        return $target.removeClass('can--drop', 'can--catch');
      }
    });
  }

  control_drag_zone_.prototype.run = function(name, cb) {
    return this.block.run(name, cb);
  };

  control_drag_zone_.prototype.hide = function() {
    return $(".droppable-" + this.counter_id).css({
      display: 'none'
    });
  };

  control_drag_zone_.prototype.show = function() {
    return $(".droppable-" + this.counter_id).css({
      display: 'block'
    });
  };

  control_drag_zone_.prototype.get_selector = function() {
    var selector;
    selector = ".droppable-" + this.counter_id;
    return selector;
  };

  control_drag_zone_.prototype.get_id = function() {
    return this.counter_id;
  };

  control_drag_zone_.prototype.is_filled = function() {
    return this.filled;
  };

  control_drag_zone_.prototype.get_name = function() {
    var return_value;
    return return_value = {
      block_name: this.block_name,
      block: this.block
    };
  };

  return control_drag_zone_;

})();
