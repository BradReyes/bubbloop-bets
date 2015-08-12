class @block_my_location_

	constructor: ()->
		@my_location =
			name: "me"
			instagram_id: null
			vid_id: null

		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable me_block Who" name="my_location">
			Me
		</div>
		""").appendTo ".drag-zone"


	run: (cb)=>
		# navigator.geolocation.getCurrentPosition (position) =>
		# 	my_lat = position.coords.latitude
		# 	my_lng = position.coords.longitude

		# 	my_lat_lng = new google.maps.LatLng my_lat, my_lng
		# 	# alert "#{my_lat_lng.lat()}, #{my_lat_lng.lng()}"
		# 	cb my_lat_lng
		# "me"
		@my_location

	filter_items: () =>
		#what_filter
		temp_list = $(".draggable.What")
		i = 0
		while i < temp_list.length
			name = $(temp_list[i]).attr "name"
			block = window["block_#{name}"]
			if name is "geocaching"
				# temp_list[i].parentNode.removeChild temp_list[i]
				block.filter_items()
			i++

