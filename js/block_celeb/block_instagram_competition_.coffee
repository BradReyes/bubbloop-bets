class @block_instagram_competition_
	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celeb What" name="instagram_competition">
			Instagram Competition
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		"instagram_competition"