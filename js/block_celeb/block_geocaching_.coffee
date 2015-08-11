class @block_geocaching_

	constructor: ()->
		css = """
			/*.geocaching_block_ {
				background-image: url(http://images.clipartpanda.com/map-clip-art-treasure-map4.png);
				background-size: 110px 110px;
				background-position: center;
				background-repeat: no-repeat;
			}*/
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="geocaching_block_ drag-wrap draggable celeb What" name="geocaching">
			<img style='width:80%;height:80%;position:absolute;top:11%;left:11%;' src='http://images.clipartpanda.com/map-clip-art-treasure-map4.png'>
		</div>
		""").appendTo ".drag-zone"

	get_type: () =>
		"action"

	filter_items: () =>
		temp_list = $(".draggable.What")
		i = 0
		while i < temp_list.length
			name = $(temp_list[i]).attr "name"
			temp_block = window["block_#{name}"]
			if temp_block.get_type() is "action"
				temp_list[i].parentNode.removeChild temp_list[i]
			i++


	run: (who, where, action, helpers)=>
		console.log typeof who
		console.log where
		console.log action

		@begin_animation()
		geocaching = ()=>
			# perhaps change later to accomadate more who 
			if ($.inArray("me", who) is -1) or (who.length isnt 1)
				alert "Wrong who for this"
				return

			@my_location (latLng) =>
				cur_lat = latLng.lat()
				cur_lng = latLng.lng()
				$("#geocaching-message-coordinate").text "#{cur_lat}, #{cur_lng}"

				console.log where
				for location in where

					polygon_area = new google.maps.Polygon
						paths: location

					if google.maps.geometry.poly.containsLocation latLng, polygon_area
						action()

		geocaching()
		setInterval geocaching, 7000

	my_location: (cb) =>
		navigator.geolocation.getCurrentPosition (position) =>
			my_lat = position.coords.latitude
			my_lng = position.coords.longitude

			my_lat_lng = new google.maps.LatLng my_lat, my_lng
			# alert "#{my_lat_lng.lat()}, #{my_lat_lng.lng()}"
			cb my_lat_lng


	begin_animation: () =>
		$("#new-button").remove()
		$("#blackened-background-button").remove()
		$(".drop-zone").remove()
		$("<div id='white-background-geocaching'></div>").prependTo $("body")
		$("#white-background-geocaching").css
			width: '100%'
			height: '100%'
			# 'background-color': 'white'
			'z-index': '1500'
			'background-image': 'url("img/earth.gif")'
			'background-size': '70% auto'
			'background-repeat': 'no-repeat'
			'background-position': 'center 30%'
		$("<h4 id='geocaching-message-coordinate'>##</h4>").prependTo $("body")
		$("</br><h1 id='geocaching-message'>Your Coordinates</h1>").prependTo $("body")
		$("#geocaching-message").css
			'text-align': 'center'
			'color': 'white'
		$("#geocaching-message-coordinate").css
			'text-align': 'center'
			'color':'white'