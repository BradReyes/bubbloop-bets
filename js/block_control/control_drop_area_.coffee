class @control_drop_area_

	constructor: ()->
		css = """
			.drop_area {
				position: relative;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id='current-step' class='text'></div>
		<div class='drop_area' role='drop_area'></div>
		""").appendTo $("body")
		# left, top, diameter
		#@celebrity = new control_drag_zone_ 5, 5, 365, 'celeb'
		@add_bubble_sections()
		@add_center_button()

	add_bubble_sections: () =>
		# left, top, diamater, bubble_type
		bubble_size = 130
		# new bubble_section_ 50, 5, bubble_size, 'Who?'
		# new bubble_section_ 200, 5, bubble_size, "What?"
		# new bubble_section_ 5, 150, bubble_size, "When?"
		# new bubble_section_ 240, 150, bubble_size, "Where?"
		# new bubble_section_ 125, 250, bubble_size, "Why?"
		height_adjustment = 90

		# upside down
		# @who = new bubble_section_ 50, 5 + height_adjustment, bubble_size, 'Who'
		# @what = new bubble_section_ 200, 5 + height_adjustment, bubble_size, "What"
		# @when = new bubble_section_ 5, 150 + height_adjustment, bubble_size, "When"
		# @where = new bubble_section_ 240, 150 + height_adjustment, bubble_size, "Where"
		# @why = new bubble_section_ 125, 250 + height_adjustment, bubble_size, "Why"

		# like a house
		@who = new bubble_section_ 125, 5 + height_adjustment, bubble_size, 'Who'
		@what = new bubble_section_ 195, 240 + height_adjustment, bubble_size, "What"
		@when = new bubble_section_ 5, 110 + height_adjustment, bubble_size, "When"
		@where = new bubble_section_ 240, 110 + height_adjustment, bubble_size, "Where"
		@why = new bubble_section_ 55, 240 + height_adjustment, bubble_size, "Why"

		# top: 330
		# left: 5
		$("""
			<div id='expand-navigation' style='
				background-image:url(http://www.outsource-force.com/blog/wp-content/uploads/2013/11/back-button.png);
				background-size: 80px 80px;
				position: absolute;
				top: 330px;
				left: -110px;
				width: 80px;
				height: 80px;
				z-index: 3001;
			'>
			</div>
		""").appendTo $("body")

	add_center_button: () =>
		$build_button = $("""
			<div id='build_button'>
				Build
			</div>
		""")

		css = """
			#build_button {
				position: absolute;
				top: 235px;
				left: 138px;
				border-radius: 100px;
				width: 100px;
				height: 100px;
				/*background-color: white;*/
				/*opacity: 0.7;*/
				line-height: 100px;
				text-align: center;
				border: 1px solid black;
				background: rgba(255, 255, 255,0.8);

			}
		"""

		$("<style type='text/css'></style>").html(css).appendTo "head"

		$build_button.appendTo $("body")
		$build_button.on "tap click", =>
			# alert "clicked or tapped"
			@run()


	step_animation: (new_text) =>
		duration = 200
		$next = $(".step-by-step")
		$next.velocity
			left: '-400'
		,
			duration: duration
			complete: () =>
				$next.text new_text
				$next.velocity
					left: '5'
				,
					duration: duration

		# setTimeout () =>
		# 	$next.text new_text
		# , duration


	split_zones: (original_drag_zone, new_drag_zone) =>
		# Logic is as follows
		# this is called when this is dropped in the drop zone
		# this will move the drag zones respectively

	expand: (block_name) ->
		# current_counter = window.counter
		# switch current_counter
		# 	when 1 #this is after celeb has been dragged in
		# 		#will expand to drop zone in celeb
		# 		@location = new control_drag_zone_ 45, 35, 205, 'source'
		# 		# .text "Choose your logic"
		# 		@step_animation "Choose your logic"

		# 		# @source.run(@celebrity)
		# 	when 2
		# 		#expand to overlap once
		# 		@destination = new control_drag_zone_ 125, 35, 205, 'filter'
		# 	when 3
		# 		#expand to triple circles
		# 		@action = new control_drag_zone_ 85, 142, 205, 'action'
		# 		# $(".step-by-step").text "Choose your output"
		# 		@step_animation "Choose your output"
		# 	when 4
		# 		#run button shows up!
		# 		# $(".step-by-step").text "Press run!"
		# 		@step_animation "Tap run!"
		# 		@create_button()

	create_button: () ->
		$blacken = $("<div id='blackened-background-button'></div>").css
			'z-index':'500'
			'opacity': '0.5'
			'background-color': 'black'
			width: '100%'
			height: '100%'
			position: 'absolute'
			left: '0px'
			top: '0px'

		$("body").prepend $blacken

		# This is the button!
		$new_div = $("""
			<div id="new-button">
				<p style='position:absolute;font-size: 25px;left:17px;top:5px;' >RUN!</p>
			</div>
		""")

		$new_div.css
			borderRadius: 100
			width: 90
			height: 90
			position: 'absolute'
			top: 140
			left: 140
			zIndex: 1000
			backgroundColor: 'white'
		$("body").prepend $new_div
		$new_div.addClass 'can--drop'
		$new_div.bind 'tap click',()=>
			@run()

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

	begin_competition: (competitors)=>
		#alert "Remving everything"
		$("#matchup-container").remove()
		$("#new-button").remove()
		$("#blackened-background-button").remove()
		$(".drop-zone").css "display","none"
		$(".drag-zone-background").remove()
		$(".drag-zone").css "display", "none"
		$("#current-step").remove()
		$(".delete-p-tags").remove()

		css = """
			.instagram-matchup-screen {
				/*width: 33%;*/
				display: inline;
				text-align: center;
			
			}

			.profile-pic-matchup {
				width: 150px;
				height: auto;
				border-radius: 200px;
			}

			.vs-text {
				height: 300px;
				padding: 30px;
				font-size: 150%;
				color: white;
			}

			.counter-matchup {
				display: block;
				color: white;
			}

			.not-main-pic {
				width: 50px;
				height: auto;
				border-radius: 200px;
			}

		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
			<div id='matchup-container'>
			</div>
		""").appendTo $("body")

		$("""
			<div class='instagram-matchup-screen profile-pic-matchup' style='position:absolute;top:170px;left:10px;'>
				<img class='profile-pic-matchup' src='#{competitors.first_val[1].images.standard_resolution.url}'>
				<img class='not-main-pic' style='position:absolute;top:0px;left:0px;' src='#{competitors.first_val[1].user.profile_picture}'>
				<p id="instagram-matchup-counter-1" class='counter-matchup'> TEST HERE 1</p>
			</div>
		""").appendTo $("#matchup-container")
		
		$("""
			<div class='instagram-matchup-screen vs-text' style='position:absolute;top:200px;left:140px;'>
				VS
			</div>
		""").appendTo $("#matchup-container")

		$("""
			<div class='instagram-matchup-screen profile-pic-matchup' style='position:absolute;top:170px;left:215px;'>
				<img class='profile-pic-matchup' src='#{competitors.second_val[1].images.standard_resolution.url}'>
				<img class='not-main-pic' style='position:absolute;top:0px;right:0px;' src='#{competitors.second_val[1].user.profile_picture}'>
				<p id="instagram-matchup-counter-2" class='counter-matchup'> TEST HERE 2</p>
			</div>
		""").appendTo $("#matchup-container")

		$("body").css 'text-align','center'
		$("""
			<p class='delete-p-tags' style='margin:0px;margin-top:450px;font-size:200%;color:white;'> GOAL </p>
			<p id='put-goal-here' class='delete-p-tags' style='margin:0px;font-size:200%;color:white;'> #### </p>
		""").appendTo $("body")

	show_winner: (winner, player1) =>
		$(".delete-p-tags").remove()
		$container = $("#matchup-container")
		$container.html " "
		$container.css "text-align", "center"
		# This is the middle image
		#style='width:300px;height:auto;border-radius:200px;margin-top:20%;
		if player1
			$("""
				<img id='actual-pic-animation' src='#{winner.images.standard_resolution.url}' 
				style='width:150px;height:auto;border-radius:200px;position:absolute;top:170px;left:10px;'>
			""").appendTo $container
			$info_container = $("<div id='info-matchup-container'></div>")
			$info_container2 = $("<div id='info-matchup-container2'></div>")
			$info_container.appendTo $container
			$info_container.css
				"display":'flex'
				'justify-content':'center'
				'align-items':'center'
			$info_container2.appendTo $container
			#position:absolute;top:390px;left:70px;
				#width:50px;height:auto;border-radius:200px;margin-top:0px;
			$("""
				<img id='profile-pic-animation' src='#{winner.user.profile_picture}' 
				style='position:absolute;top:170px;left:10px;
				width:50px;height:auto;border-radius:200px;'>
			""").appendTo $info_container
			$("""
				<p id='results-winnerinfo-1' 
				style='position:absolute;top:365px;left:120px;
				font-size:200%;margin:20px;margin-left:10px;color:white;
				'> #{winner.user.username} </p>
			""").appendTo $info_container
			$("""
				<p id='results-winnerinfo-2' style='display:block;font-size:200%;color:white;margin-top:440px;padding:0px;'
				> is the WINNER! </p>
			""").appendTo $info_container2

			### Animations here ###
			$("#results-winnerinfo-1").velocity "fadeIn", 
				'duration':2500
			$("#results-winnerinfo-2").velocity "fadeIn",
				'duration': 3000
			$("#actual-pic-animation").velocity
				top: 80
				left: 40
				width: 300
				height: 300
			$("#profile-pic-animation").velocity
				top: 390
				left: 70
		else
			$("""
				<img id='actual-pic-animation' src='#{winner.images.standard_resolution.url}' 
				style='width:150px;height:auto;border-radius:200px;position:absolute;top:170px;left:215px;'>
			""").appendTo $container
			$info_container = $("<div id='info-matchup-container'></div>")
			$info_container2 = $("<div id='info-matchup-container2'></div>")
			$info_container.appendTo $container
			$info_container.css
				"display":'flex'
				'justify-content':'center'
				'align-items':'center'
			$info_container2.appendTo $container
			$("""
				<img id='profile-pic-animation' src='#{winner.user.profile_picture}' 
				style='position:absolute;top:170px;left:315px;
				width:50px;height:auto;border-radius:200px;'>
			""").appendTo $info_container
			$("""
				<p id='results-winnerinfo-1' 
				style='position:absolute;top:365px;left:120px;
				font-size:200%;margin:20px;margin-left:10px;color:white;
				'> #{winner.user.username} </p>
			""").appendTo $info_container
			$("""
				<p id='results-winnerinfo-2' style='display:block;font-size:200%;color:white;margin-top:440px;padding:0px;'
				> is the WINNER! </p>
			""").appendTo $info_container2

			### Animations here ###
			$("#results-winnerinfo-1").velocity "fadeIn", 
				'duration':2500
			$("#results-winnerinfo-2").velocity "fadeIn",
				'duration': 3000
			$("#actual-pic-animation").velocity
				top: 80
				left: 40
				width: 300
				height: 300
			$("#profile-pic-animation").velocity
				top: 390
				left: 70

	# use bubble.block_name() to get block_name
	run: ()->
		what_name = @what.block_name().block_name
		# check which path to take
		if what_name is "instagram_competition"
			@filtering_app()
		else if what_name is "geocaching"
			@geocaching_app()
		else #no path specified
			alert "Please specify a what"

		# geocaching path
		# @geocaching_app()

		#instagram filter path
		#@filtering_app()


		# @begin_animation()
		# geocaching = ()=>
		# 	@location.run (latLng) =>
		# 		cur_lat = latLng.lat()
		# 		cur_lng = latLng.lng()
		# 		$("#geocaching-message-coordinate").text "#{cur_lat}, #{cur_lng}"
		# 		@destination.run latLng, (is_true)=>
		# 			@action() if is_true
		# geocaching()
		# setInterval geocaching, 7000
		# @location.run =>
		# 	console.log "Both are done yaaay"
		#alert "Got in run"
		# competition = () =>
		# 	console.log "Got in competition"
		# 	@location.run (competitors) =>
		# 		#alert "Got in competitors"
		# 		console.log competitors
		# 		@begin_competition competitors
		# 		@destination.run competitors, (winner, player1) =>
		# 			console.log "got in winner"
		# 			# return instagram object of the winner
		# 			if winner?
		# 				clearInterval @stop_interval
		# 				console.log "There's a winner!"
		# 				@show_winner winner, player1
		# competition()
		# @stop_interval = setInterval competition, 7000

	# INSTAGRAM FILTERING
	filtering_app: () =>
		# check for parameters
		# alert @where.block_name().block_name
		console.log @who.block_name().block_name
		if (@who.block_name().block_name is null) or (@who.block_name().block_name is "my_location")
			alert "Specify a correct who"
			return
		# if (@where.block_name().block_name is null) or (@where.block_name().block_name isnt "hoovertower")
		# 	alert "Not a correct where block"
		# 	return

		if (@why.block_name().block_name is null) or 
		((@why.block_name().block_name isnt "display_image"))
			alert "Not a correct why block"
			return
		$(".step-by-step").remove()
		$("#build_button").remove()

		@get_images (images) =>
			# images is an array of images from the instagram
			# This is the for loop that iterates through the feed
			async.forEachOfSeries images, (element, i, cb) =>
				if @filter element
					@filter_action element, cb
				else
					cb()
				return
			, (err) ->
				if outer_cb?
					outer_cb()
				else
					console.log "LOOP ENDED W/O OUTER_CB"

	filter: (image)=>
		# return true or false
		# filters via hashtags
		# tags = image.tags
		# console.log image
		# # tag = $("#hashtag_input#{@counter}").val().toLowerCase()

		# lower_tags = tags.map (string)->
		# 	return string.toLowerCase()

		num_likes = image.likes.count

		# for cur_tag in lower_tags
		# 	if cur_tag.indexOf('stanford') isnt -1
		# 		return true
		# return false
		if num_likes > 100
			return true
		return false


	filter_action: (obj, cb_done) =>
		url = obj.images.standard_resolution.url
		$('<div id="white-background"></div><div id="image-div"></div><img class="new_image" src='+url+' />').appendTo "body"

		$('#white-background').css
			backgroundColor: 'white'
			backgroundSize: 'cover'
			backgroundPosition: 'center'
			position: 'fixed'
			margin: 0
			top: 0
			bottom: 0
			right: 0
			left: 0
			width: '100%'
			height: '100%'
			zIndex: 10000000

		$('#image-div').css
			backgroundImage:"url(#{url})"
			backgroundSize:'cover'
			backgroundPosition:'center'
			position:'fixed'
			margin: 0
			top: '-50%'
			bottom: 0
			right: 0
			left:'-50%'
			width : '200%'
			height : '200%'
			zIndex: 10000001
			opacity: 0.35
			transform: 'rotate(15deg)'

		$('.new_image').css
			maxWidth: '120%'
			maxHeight: '100%'
			bottom: 0
			left: 0
			margin: 'auto'
			overflow: 'auto'
			position: 'fixed'
			right: 0
			top: 0
			zIndex: 10000002

		setTimeout cb_done, 2000


	get_images: (cb) =>
		# get the feed for instagram
		# get userid later, this will be from id of block selected
		given_id = @who.block_name().block.run()
		all_posts = []
		feed = new Instafeed
			get: 'user'
			userId: given_id
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			limit: 60
			error: ()->
				console.log "instagram error"
			success: (json)=>
				list = json.data
				# loops to concatenate
				for cur in list
					all_posts.push cur
				#setTimeout @loop_done, 0, cb
				cb all_posts

		feed.run()



	# GEOCACHING APP
	geocaching_app: () =>
		# check for parameters
		# alert @where.block_name().block_name
		console.log @who.block_name().block_name
		if (@who.block_name().block_name is null) or (@who.block_name().block_name isnt "my_location")
			alert "Specify a correct who"
			return
		if (@where.block_name().block_name is null)
			alert "Not a correct where block"
			return

		if (@why.block_name().block_name is null) or 
		((@why.block_name().block_name isnt "ding") and (@why.block_name().block_name isnt "pizza"))
			alert "Not a correct why block"
			return

		$(".step-by-step").remove()
		$("#build_button").remove()

		@begin_animation()
		geocaching = ()=>
			@my_location (latLng) =>
				cur_lat = latLng.lat()
				cur_lng = latLng.lng()
				$("#geocaching-message-coordinate").text "#{cur_lat}, #{cur_lng}"
				@where.block_name().block.run latLng, (is_true)=>
					@coord_action() if is_true
		geocaching()
		setInterval geocaching, 7000

	### These are for the components of the geocaching app, logic still separated ###
	my_location: (cb) =>
		navigator.geolocation.getCurrentPosition (position) =>
			my_lat = position.coords.latitude
			my_lng = position.coords.longitude

			my_lat_lng = new google.maps.LatLng my_lat, my_lng
			# alert "#{my_lat_lng.lat()}, #{my_lat_lng.lng()}"
			cb my_lat_lng

	destination: (latlng, cb)=>
		southWestLat = 37.428289997495774
		southWestLng = -122.167537441803
		northWestLat = 37.42743800008019
		northWestLng = -122.16646455819705
		northEastLat = 37.428289997495774
		northEastLng = -122.16646455819705
		southEastLat = 37.428289997495774
		southEastLng = -122.167537441803

		rectangle = [
			new google.maps.LatLng southWestLat, southWestLng
			new google.maps.LatLng northWestLat, northWestLng
			new google.maps.LatLng northEastLat, northEastLng
			new google.maps.LatLng southEastLat, southEastLng
		]

		polygon_area = new google.maps.Polygon
			paths: rectangle

		if google.maps.geometry.poly.containsLocation latlng, polygon_area
			cb true
		else
			cb false

	coord_action: () =>
		@why.block_name().block.run()



