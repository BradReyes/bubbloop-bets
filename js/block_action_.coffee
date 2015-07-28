class @block_action_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable action" name="action">
			ACTION
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		"ACTION IS HERE"