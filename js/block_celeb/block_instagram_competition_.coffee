class @block_instagram_competition_
	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celeb What" name="instagram_competition">
			<img style='width:100%;height:auto;position:absolute;top:16%;left:0%;' src='http://d13zeczpqm2715.cloudfront.net/wp-content/uploads/2015/06/instagram-logo-vector-image.png'>
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		"instagram_competition"