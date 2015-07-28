class @block_play_audio_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable action" name="play_audio">
			PLAY AUDIO
		</div>
		""").appendTo ".drag-zone"

	run: (obj, cb) =>
		audio = new Audio()
		audio.src = obj.preview_url
		$(audio).bind 'ended', ->
			cb()
		audio.play()

