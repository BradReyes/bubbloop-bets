class @block_geocaching_

	constructor: ()->
		css = """
			/*#geocaching_block_ {
				background-image: url(http://images.clipartpanda.com/map-clip-art-treasure-map4.png);
				background-size: 110px 110px;
				background-position: center;
				background-repeat: no-repeat;
			}*/
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div id='geocaching_block_' class="drag-wrap draggable celeb What" name="geocaching">
			<img style='width:80%;height:80%;position:absolute;top:11%;left:11%;' src='http://images.clipartpanda.com/map-clip-art-treasure-map4.png'>
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		"geocaching"