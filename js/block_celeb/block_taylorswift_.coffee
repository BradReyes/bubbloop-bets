class @block_taylorswift_

	constructor: ()->
		@taylor_swift =
			name: "taylor swift"
			instagram_id: 11830955
			vid_id: "QcIy9NiNbmo"

		css = """
		#instafeed {
			display: none;
		}

		.taylor-image {
			height:130%;
			position: relative;
			left: -65px;
			top:0px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celebrity celeb Who" name="taylorswift">
			<img class="taylor-image" src="img/taylorswift.jpg">
			<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		@taylor_swift

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
