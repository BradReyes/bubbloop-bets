class @block_my_location_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable source" name="my_location">
			MY LOCATION
		</div>
		""").appendTo ".drag-zone"


	run: (cb)=>
		navigator.geolocation.getCurrentPosition (position) =>
			my_lat = position.coords.latitude
			my_lng = position.coords.longitude

			my_lat_lng = new google.maps.LatLng my_lat, my_lng
			# alert "#{my_lat_lng.lat()}, #{my_lat_lng.lng()}"
			cb my_lat_lng
