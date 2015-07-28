class @block_drake_

	constructor: ()->
		@drake =
			name: "drake"
			instagram_id: 14455831

		css = """
		#instafeed {
			display: none;
		}

		#drake-image {
			height:100%;
			position: relative;
			left: -50px;
			top: 0px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celeb" name="drake">
			<img id="drake-image" src="img/drake.jpg">
			<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		@drake
