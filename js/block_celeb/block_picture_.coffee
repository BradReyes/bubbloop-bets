class @block_picture_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celeb" name="picture">
			PICTURE
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		@drake
