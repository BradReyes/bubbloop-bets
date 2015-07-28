class @block_taylorswift_

	constructor: ()->
		@taylor_swift =
			name: "taylor swift"
			instagram_id: 11830955

		css = """
		#instafeed {
			display: none;
		}

		#taylor-image {
			height:130%;
			position: relative;
			left: -65px;
			top:0px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celeb" name="taylorswift">
			<img id="taylor-image" src="img/taylorswift.jpg">
			<div id="instafeed"></div>
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		@taylor_swift
