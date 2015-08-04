class @block_geocaching_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celeb What" name="geocaching">
			geocaching
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		"geocaching"