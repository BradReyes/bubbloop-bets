class @block_hashtag_

	constructor: ()->
		if window.hashtag_counter?
			window.hashtag_counter++
		else
			window.hashtag_counter = 0

		@counter = window.hashtag_counter
		css = """
		[name=hashtag] {
			font-size: 50px;
		}
		#hashtag_input#{@counter} {
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
		<div class="drag-wrap draggable filter" name="hashtag">
			#
			<input id="hashtag_input#{@counter}" type="text" value="">
		</div>
		""").appendTo ".drag-zone"

		interact("[name=hashtag]")
		.on 'tap', (event) =>
			event.preventDefault()
			$("#hashtag_input#{@counter}").focus()
			@expand()


	blacken_background: () =>
		$blacken = $ "<div id='blacken-input'>"
		$blacken.css
			zIndex: 500
			backgroundColor: 'rgba(0,0,0,0.5)'
			width: '100%'
			height: '100%'
			position: 'absolute'
			left: 0
			top: 0
		$("body").prepend $blacken
		# $("body").bind 'touchstart', =>
		# 	$("#popup-input").blur()
		# 	$("#popup-input").remove()
		# 	$blacken.remove()

	expand: () =>
		@blacken_background()
		# width = window.outerWidth;
		# height = window.outerHeight;
		height = document.documentElement.clientHeight
		width = document.documentElement.clientWidth
		box_width = width / 2
		left = width/2 - box_width/2
		value = $("#hashtag_input#{@counter}").val()
		$popup_input = $("<input id='popup-input' type='text'>")
		$popup_input.val value
		# $popup_input = $("#popup-input")

		$popup_input.appendTo $("body")

		#sets cursor at end
		str_length= $popup_input.val().length * 2;
		$popup_input.focus()
		$popup_input[0].setSelectionRange(str_length, str_length)

		#now get the position of the original input box
		position = $("#hashtag_input#{@counter}").offset()

		#need to get the scal at this point
		actual = $("#hashtag_input#{@counter}")[0].getBoundingClientRect().width
		actual_height = $("#hashtag_input#{@counter}")[0].getBoundingClientRect().height
		scaled = $("#hashtag_input#{@counter}")[0].offsetWidth
		scale = actual/scaled

		original_width = $("#hashtag_input#{@counter}").innerWidth()
		original_height = $("#hashtag_input#{@counter}").innerHeight()
		$("#popup-input").css
			zIndex: 600
			position: "fixed"
			left: position.left
			top: position.top
			fontSize: 16
			textAlign: 'center'
			width: original_width*scale + 1
			height: actual_height
		$popup_input.velocity
			width: box_width
			height: original_height
			top: height/2
			left: left

		$("#popup-input").on 'keyup', (event) =>
			if event.which is 13 #return key
				$("#popup-input").blur()
				# $("#popup-input").remove()
				# $("#blacken-input").remove()
			else
				new_value = $("#popup-input").val()
				# console.log new_value
				$("#hashtag_input#{@counter}").val(new_value)
		#this is what happens when the user clicks away from the input box
		$("#popup-input").blur =>
			$("#blacken-input").remove()
			$("#popup-input").remove()
			

	run: (element)=>
		# tags is an array of strings
		tags = element.tags
		tag = $("#hashtag_input#{@counter}").val().toLowerCase()

		lower_tags = tags.map (string)->
			return string.toLowerCase()

		for cur_tag in lower_tags
			if cur_tag.indexOf(tag) isnt -1
				return true
		return false