class @block_dish_

	# Hoover tower coordinates
	# 37.427864, -122.167001

	# This is the coordinates 
	# Northeast lat/lng, NW, SW, SE
	# 37.428289997495774, -122.16646455819705
	# 37.42743800008019, -122.16646455819705
	# 37.42743800008019, -122.167537441803
	# 37.428289997495774, -122.167537441803
	constructor: ()->
		southWestLat = 37.40845181
		southWestLng = -122.1797698
		northWestLat = 37.40872984
		northWestLng = -122.17981137
		northEastLat = 37.40873836
		northEastLng = -122.17942916
		southEastLat = 37.40846672
		southEastLng = -122.17938758

		css = """
			.dish {
				background-image: url(http://farm3.static.flickr.com/2045/3532400496_cf122cd481.jpg);
				background-size: cover;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="dish drag-wrap draggable filter Where" name="dish">
		</div>
		""").appendTo ".drag-zone"

		@rectangle = [
			new google.maps.LatLng southWestLat, southWestLng
			new google.maps.LatLng northWestLat, northWestLng
			new google.maps.LatLng northEastLat, northEastLng
			new google.maps.LatLng southEastLat, southEastLng
		]


	run: () =>
		# if google.maps.geometry.poly.containsLocation latlng, @polygon_area
		# 	cb true
		# else
		# 	cb false
		@rectangle