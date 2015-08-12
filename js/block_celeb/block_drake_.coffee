class @block_drake_

	constructor: ()->
		@drake =
			name: "drake"
			instagram_id: 14455831
			vid_id: "b2AcxL88DoI"

		css = """
		#instafeed {
			display: none;
		}

		.drake-image {
			height:100%;
			position: relative;
			left: -50px;
			top: 0px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celebrity celeb Who" name="drake">
			<img class="drake-image" src="img/drake.jpg">
			<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		@drake

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
