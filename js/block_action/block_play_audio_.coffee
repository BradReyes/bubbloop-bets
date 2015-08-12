class @block_ding_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable action general_action Why" name="ding">
			<img style='width:80%;height:80%;position:absolute;top:9%;left:9%;' src='img/tran_bell.png'>
		</div>
		""").appendTo ".drag-zone"

		@audio = null

	run: (obj, cb) =>
		if @audio is null
			@audio = new Audio("./sound/Ding.mp3")
		# audio.src = obj.preview_url
		# $(audio).bind 'ended', ->
		# 	cb()
		@audio.pause()
		@audio.play()

