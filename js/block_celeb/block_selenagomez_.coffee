class @block_selenagomez_

	constructor: ()->

		@selena_gomez =
			name: "selena gomez"
			instagram_id: 460563723
		css = """
		#instafeed {
			display: none;
		}
		#selena-image {
			height:110%;
			position: relative;
			left: -60px;
			bottom:0;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable Who" name="selenagomez">
			<img id="selena-image" src="img/selenagomez.jpg">
			<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

		selenagomez = 460563723

		feed = new Instafeed
			get: 'user'
			userId: selenagomez
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)=>
				@images = json.data

		feed.run()

	run: ()=>
		@selena_gomez.instagram_id
