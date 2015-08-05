class @block_lawschool_

	# Hoover tower coordinates
	# 37.427864, -122.167001

	# This is the coordinates 
	# Northeast lat/lng, NW, SW, SE
	# 37.428289997495774, -122.16646455819705
	# 37.42743800008019, -122.16646455819705
	# 37.42743800008019, -122.167537441803
	# 37.428289997495774, -122.167537441803
	constructor: ()->
		southWestLat = 37.428289997495774
		southWestLng = -122.167537441803
		northWestLat = 37.42743800008019
		northWestLng = -122.16646455819705
		northEastLat = 37.428289997495774
		northEastLng = -122.16646455819705
		southEastLat = 37.428289997495774
		southEastLng = -122.167537441803

		css = """
			#lawschool {
				background-image: url(http://chronicle.com/blogs/buildings/files/2011/05/stanfordlaw.jpg);
				background-size: cover;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id="lawschool" class="drag-wrap draggable filter Where" name="lawschool">
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