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

	add_bubble_sections: () =>
		# left, top, diamater, bubble_type
		bubble_size = 130
		# new bubble_section_ 50, 5, bubble_size, 'Who?'
		# new bubble_section_ 200, 5, bubble_size, "What?"
		# new bubble_section_ 5, 150, bubble_size, "When?"
		# new bubble_section_ 240, 150, bubble_size, "Where?"
		# new bubble_section_ 125, 250, bubble_size, "Why?"
		height_adjustment = 100

		new bubble_section_ 50, 5 + height_adjustment, bubble_size, 'Who'
		new bubble_section_ 200, 5 + height_adjustment, bubble_size, "What"
		new bubble_section_ 5, 150 + height_adjustment, bubble_size, "When"
		new bubble_section_ 240, 150 + height_adjustment, bubble_size, "Where"
		new bubble_section_ 125, 250 + height_adjustment, bubble_size, "Why"

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

	run: ()->
		$(".step-by-step").remove()
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
		competition = () =>
			console.log "Got in competition"
			@location.run (competitors) =>
				#alert "Got in competitors"
				console.log competitors
				@begin_competition competitors
				@destination.run competitors, (winner, player1) =>
					console.log "got in winner"
					# return instagram object of the winner
					if winner?
						clearInterval @stop_interval
						console.log "There's a winner!"
						@show_winner winner, player1
		competition()
		@stop_interval = setInterval competition, 7000

