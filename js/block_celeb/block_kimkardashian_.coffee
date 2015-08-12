class @block_kimkardashian_

	constructor: ()->

		@kim_kardashian = 
			name: "kim kardashian"
			instagram_id: 18428658
			vid_id: "GT3KMalt8Bk"

		css = """
		#instafeed {
			display: none;
		}
		.kim-image {
			width:120%;
			position: relative;
			left: -15px;
			bottom:0;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celebrity Who" name="kimkardashian">
			<img class="kim-image" src="img/kimkardashian.jpg">
			<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

		kimkardashian = 18428658

		feed = new Instafeed
			get: 'user'
			userId: kimkardashian
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			error: ()->
				console.log "instagram error"
			success: (json)=>
				@images = json.data

		feed.run()

	run: ()=>
		@kim_kardashian

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