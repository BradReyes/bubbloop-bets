class @block_source_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable source" name="source">
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		"SOURCE IS HERE"