// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_lawschool_ = (function() {
  function block_lawschool_() {
    this.run = bind(this.run, this);
    var css, northEastLat, northEastLng, northWestLat, northWestLng, rectangle, southEastLat, southEastLng, southWestLat, southWestLng;
    southWestLat = 37.428289997495774;
    southWestLng = -122.167537441803;
    northWestLat = 37.42743800008019;
    northWestLng = -122.16646455819705;
    northEastLat = 37.428289997495774;
    northEastLng = -122.16646455819705;
    southEastLat = 37.428289997495774;
    southEastLng = -122.167537441803;
    css = "#lawschool {\n	background-image: url(http://chronicle.com/blogs/buildings/files/2011/05/stanfordlaw.jpg);\n	background-size: cover;\n}";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div id=\"lawschool\" class=\"drag-wrap draggable filter Where\" name=\"lawschool\">\n</div>").appendTo(".drag-zone");
    rectangle = [new google.maps.LatLng(southWestLat, southWestLng), new google.maps.LatLng(northWestLat, northWestLng), new google.maps.LatLng(northEastLat, northEastLng), new google.maps.LatLng(southEastLat, southEastLng)];
    this.polygon_area = new google.maps.Polygon({
      paths: rectangle
    });
  }

  block_lawschool_.prototype.run = function(latlng, cb) {
    if (google.maps.geometry.poly.containsLocation(latlng, this.polygon_area)) {
      return cb(true);
    } else {
      return cb(false);
    }
  };

  return block_lawschool_;

})();