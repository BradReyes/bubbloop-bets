class @block_beyonce_

	constructor: ()->
		@beyonce =
			name: "beyonce"
			instagram_id: 247944034
			vid_id: "k4YRWT_Aldo"

		css = """
		#instafeed {
			display: none;
		}

		.beyonce-image {
			height:100%;
			position: relative;
			left: -40px;
			bottom:0;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celebrity Who" name="beyonce">
			<img class='beyonce-image' src="img/beyonce.jpg">
		<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		@beyonce

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

