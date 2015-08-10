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
		# @youtube_app(people)
		complete_query = ""
		for celeb in people
			complete_query += "#{celeb.name} "
		# search encodeURIComponent complete_query




	# Test for the youtube api
	search: (query, cb) =>
		YT_URL = 'https://www.googleapis.com/youtube/v3/search'
		YT_API_KEY = 'AIzaSyDDP01Gnj3-wfoqM59xQz6pryJQhmYWCt8'
		# YT_API_KEY = 'AIzaSyDIBsEcwPfptc_THmUtO5OhU5BV6KLqFs'
		YT_EMBED_URL = 'http://www.youtube.com/embed/'
		getURL = YT_URL + "?key=" + YT_API_KEY + "&q=" + query + "&part=snippet&type=value"

		$.ajax
			method: "GET"
			url: getURL
		.done (body, response, error)=>
			# videos = JSON.parse(body).items
			videos = body.items
			console.log videos
			video_objects = []
			videos.forEach (cur)=>
				video_objects.push
					'title': cur.snippet.title,
					'source': YT_EMBED_URL + cur.id.videoId
			cb video_objects

		# youtube_app: (people) =>
	# 	# if (@who.block_name().block_name is null) or (@who.block_name().block_name is "my_location")
	# 	# 	alert "Specify a correct who"
	# 	# 	return	
	# 	# @what.expand_section()
	# 	@create_player(people)

	# create_player: (people) =>
	# 	tag = document.createElement 'script'
	# 	tag.src = "https://www.youtube.com/player_api"
	# 	firstScriptTag = document.getElementsByTagName('script')[0]
	# 	firstScriptTag.parentNode.insertBefore tag, firstScriptTag

	# 	window.onYouTubeIframeAPIReady = ()=>
			
	# 		#console.log(@who.block_vid_id())

	# 		player = new YT.Player 'youtube_player',
	# 			# videoId: @youtube_id
	# 			height: '352'
	# 			videoId: people[0].vid_id

	# 			events:	
	# 				onReady: (e)->
	# 					console.log "youtube onReady"
	# 					e.target.playVideo()
	# 				onStateChange: (e)->
	# 					console.log "youtube onStateChange"
