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
		@add_bubble_sections()
		@add_center_button()

	add_bubble_sections: () =>
		# left, top, diamater, bubble_type
		bubble_size = 130
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

	# Runs the combinations 
	# who returns an array of people
	# where returns an array of locations
	# why.run (notice it's not called) will be called from what
	# what is were the rest of the logic happens
	run: ()=>
		@when.run =>
			@what.run @who.run(), @where.run(), @why.run

















	###
	Ignore the following for now, will need later
	###
	begin_competition: (competitors)=>
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