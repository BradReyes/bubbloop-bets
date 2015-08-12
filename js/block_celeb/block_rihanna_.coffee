class @block_rihanna_

	constructor: ()->

		@rihanna = 
			name: "rihanna"
			instagram_id: 25945306
			vid_id: "B3eAMGXFw1o"

		css = """
		#instafeed {
			display: none;
		}
		.rihanna-image {
			width:130%;
			position: relative;
			left: -10px;
			bottom:0;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celebrity Who" name="rihanna">
			<img class="rihanna-image" src="img/rihanna.jpg">
			<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

		rihanna = 25945306

		feed = new Instafeed
			get: 'user'
			userId: rihanna
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)=>
				@images = json.data

		feed.run()

	run: ()=>
		@rihanna

	filter_items: () =>
		#what_filter
		temp_list = $(".draggable.What")
		i = 0
		while i < temp_list.length
			name = $(temp_list[i]).attr "name"
			block = window["block_#{name}"]
			if name is "instagram_competition"
				# temp_list[i].parentNode.removeChild temp_list[i]
				block.filter_items()
			i++
