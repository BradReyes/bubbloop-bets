class @block_beyonce_

	constructor: ()->
		@beyonce =
			name: "beyonce"
			instagram_id: 247944034

		css = """
		#instafeed {
			display: none;
		}

		#beyonce-image {
			height:100%;
			position: relative;
			left: -40px;
			bottom:0;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celeb" name="beyonce">
			<img id="beyonce-image" src="img/beyonce.jpg">
		<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		@beyonce
