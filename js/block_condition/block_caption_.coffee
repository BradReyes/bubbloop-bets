class @block_caption_

	constructor: ()->
		css = """
		[name=caption] {
			font-size: 25px;
		}
		#caption_input {
			position: absolute;
			top: 55%;
			width: 80%;
			left: 6%;
			text-align: center;
			font-size: 12px;
		}

		input[type='text'],
		input[type='number'],
		textarea {
			font-size: 16px;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable filter" name="caption">
			CAPTION
			<input id="caption_input" type="text" value="">
		</div>
		""").appendTo ".drag-zone"

		interact("[name=caption]")
		.on 'tap click', (event) =>
			event.preventDefault()
			$("#caption_input").focus()


	run: (element)=>
		input = $("#caption_input").val().toLowerCase()

		if element.caption isnt null and element.caption.text.indexOf(input) isnt -1
			return true
		return false
