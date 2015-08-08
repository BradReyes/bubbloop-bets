class @block_garden_

	# Hoover tower coordinates
	# 37.427864, -122.167001

	# This is the coordinates 
	# Northeast lat/lng, NW, SW, SE
	# 37.428289997495774, -122.16646455819705
	# 37.42743800008019, -122.16646455819705
	# 37.42743800008019, -122.167537441803
	# 37.428289997495774, -122.167537441803
	constructor: ()->
		southWestLat = 37.42800553
		southWestLng = -122.16996532
		northWestLat = 37.42796879
		northWestLng = -122.16997202
		northEastLat = 37.42797731
		northEastLng = -122.16988888
		southEastLat = 37.42802098
		southEastLng = -122.16988552

		css = """
			.garden {
				background-image: url(http://pamiatkyamesta.pise.sk/obrazky/pamiatkyamesta.pise.sk/rodin-sculpture-garden-0184e910a96ebc05f5cc392addbd573afc714cbe.jpg);
				background-size: cover;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="garden drag-wrap draggable filter Where" name="garden">
		</div>
		""").appendTo ".drag-zone"

		@rectangle = [
			new google.maps.LatLng southWestLat, southWestLng
			new google.maps.LatLng northWestLat, northWestLng
			new google.maps.LatLng northEastLat, northEastLng
			new google.maps.LatLng southEastLat, southEastLng
		]


	run: () =>
		@rectangle