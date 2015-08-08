class @block_youtube_

	constructor: ()->
		css = """
		#youtube_pic{
			position: absolute;
			left: 20px;
			top: 25px;
			width: 100px;
			height: 100px;
		}

		#youtube_player {
			position: absolute;
			top: 0px;
			left: -144px;
		}

		"""

		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable Why" name="youtube">
			<div id="youtube_player"></div>
			<img id="youtube_pic" src="img/youtube-logo.png">
		</div>
		""").appendTo ".drag-zone"



	run: (people) =>
		console.log "Got in youtube"
		console.log people
		@youtube_app(people)

	youtube_app: (people) =>
		# if (@who.block_name().block_name is null) or (@who.block_name().block_name is "my_location")
		# 	alert "Specify a correct who"
		# 	return	
		# @what.expand_section()
		@create_player(people)

	create_player: (people) =>
		tag = document.createElement 'script'
		tag.src = "https://www.youtube.com/player_api"
		firstScriptTag = document.getElementsByTagName('script')[0]
		firstScriptTag.parentNode.insertBefore tag, firstScriptTag

		window.onYouTubeIframeAPIReady = ()=>
			
			#console.log(@who.block_vid_id())

			player = new YT.Player 'youtube_player',
				# videoId: @youtube_id
				height: '352'
				videoId: people[0].vid_id

				events:	
					onReady: (e)->
						console.log "youtube onReady"
						e.target.playVideo()
					onStateChange: (e)->
						console.log "youtube onStateChange"

	###
