class @block_geocaching_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="geocaching_block_ drag-wrap draggable celeb What" name="geocaching">
			<img style='width:80%;height:80%;position:absolute;top:11%;left:11%;'
			src='http://images.clipartpanda.com/map-clip-art-treasure-map4.png'>
		</div>
		""").appendTo ".drag-zone"

	get_type: () =>
		"action"

	filter_items: () =>
		temp_list = $(".draggable.What")
		who_list = $(".draggable.Who")
		why_list = $(".draggable.Why")

		# fellow what blocks
		i = 0
		while i < temp_list.length
			name = $(temp_list[i]).attr "name"
			temp_block = window["block_#{name}"]
			if temp_block.get_type() is "action" and name isnt "geocaching"
				temp_list[i].parentNode.removeChild temp_list[i]
			else if name isnt "geocaching"
				temp_list[i].parentNode.removeChild temp_list[i]
			i++

		j = 0
		while j < who_list.length
			name = $(who_list[j]).attr "name"
			$cur = $("div[name='#{name}']")
			if name isnt "my_location"
				$cur.remove()
			j++

		k = 0
		while k < why_list.length
			name = $(why_list[k]).attr "name"
			why_block = window["block_#{name}"]
			$cur = $("div[name='#{name}']")
			if not ($cur.hasClass("general_action"))
				$cur.remove()
			k++

	check_me: (who) =>
		for cur in who
			name = cur.name
			return true if name is "me"
		return false

	run: (who, where, action, helpers)=>
		@begin_animation()
		geocaching = ()=>
			# perhaps change later to accomadate more who 
			if (not @check_me(who)) or (who.length isnt 1)
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