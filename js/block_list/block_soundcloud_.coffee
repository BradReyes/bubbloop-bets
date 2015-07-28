class @block_soundcloud_

	constructor: ()->
		css = """
		#soundcloud {
				background-image: url(img/soundcloud.png);
				background-size: cover;
		}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id="soundcloud" class="drag-wrap draggable source" name="soundcloud">
		</div>
		""").appendTo ".drag-zone"



	# IN PROGRESS
	# -----------
	run: (element)=>
		console.log "SOUNDCLOUD RUN"

		# initialize client with app credentials
		# SC.initialize
		# 	client_id: '21269af4bcee636bc4e3036d5ae81daf'
		# 	redirect_uri: "http://example.com/callback"

		# SC.get "/groups/55517/tracks", limit: 4, (tracks) ->
		# 	console.log (tracks[0].title)


		SC.initialize
			client_id: '21269af4bcee636bc4e3036d5ae81daf'

		track_url = 'http://soundcloud.com/donnietrumpet/sets/surf'
		SC.oEmbed track_url, auto_play: true, (oEmbed) ->
			console.log "oEmbed response:"
			console.log oEmbed

		# SC.whenStreamingReady (callback)
		# SC.stream(trackPath, [options], [callback])

		# SCS.oEmbed (url, [params], callbackOrContainer)

		# SC.record(options)
		# SC.recordStop
		# SC.recordPlay(options)