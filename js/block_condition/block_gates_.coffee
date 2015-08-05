class @block_gates_

	# Hoover tower coordinates
	# 37.427864, -122.167001

	# This is the coordinates 
	# Northeast lat/lng, NW, SW, SE
	# 37.428289997495774, -122.16646455819705
	# 37.42743800008019, -122.16646455819705
	# 37.42743800008019, -122.167537441803
	# 37.428289997495774, -122.167537441803
	constructor: ()->
		southWestLat = 37.43002367
		southWestLng = -122.17403859
		northWestLat = 37.43057319
		northWestLng = -122.17377573
		northEastLat = 37.43031334
		northEastLng = -122.1729067
		southEastLat = 37.4297766
		southEastLng = -122.17311054

		css = """
			#gates {
				background-image: url(http://gaspull.geeksaresexytech.netdna-cdn.com/wp-content/uploads/2009/09/cs2.jpg);
				background-size: cover;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id="gates" class="drag-wrap draggable filter Where" name="gates">
		</div>
		""").appendTo ".drag-zone"

		rectangle = [
			new google.maps.LatLng southWestLat, southWestLng
			new google.maps.LatLng northWestLat, northWestLng
			new google.maps.LatLng northEastLat, northEastLng
			new google.maps.LatLng southEastLat, southEastLng
		]

		@polygon_area = new google.maps.Polygon
			paths: rectangle


	run: (latlng, cb) =>
		if google.maps.geometry.poly.containsLocation latlng, @polygon_area
			cb true
		else
			cb false