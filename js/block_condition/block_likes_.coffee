class @block_likes_

	constructor: ()->
		css = """
			.likes-input{
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

			.likes-filter-text {
				position: absolute;
				top: -25px;
				left: 20px;
				font-size: 150%;
				font-weight: bold;
			}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable instagram_filter What" name="likes">
			<p class='likes-filter-text'>> LIKES</p>
			<input class="likes-input" type="text" value="0">
		</div>
		""").appendTo ".drag-zone"

		interact(".likes-input")
		.on 'tap', (event) =>
			event.preventDefault()
			$(".likes-input").focus()
			@expand(".likes-input")

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

	expand: (selector) =>
		@blacken_background()
		# width = window.outerWidth;
		# height = window.outerHeight;
		height = document.documentElement.clientHeight
		width = document.documentElement.clientWidth
		box_width = width / 2
		left = width/2 - box_width/2
		value = $(selector).val()
		$popup_input = $("<input id='popup-input' type='text'>")
		$popup_input.val value
		# $popup_input = $("#popup-input")

		$popup_input.appendTo $("body")

		#sets cursor at end
		str_length= $popup_input.val().length * 2;
		$popup_input.focus()
		$popup_input[0].setSelectionRange(str_length, str_length)

		#now get the position of the original input box
		position = $(selector).offset()

		#need to get the scal at this point
		actual = $(selector)[0].getBoundingClientRect().width
		actual_height = $(selector)[0].getBoundingClientRect().height
		scaled = $(selector)[0].offsetWidth
		scale = actual/scaled

		original_width = $(selector).innerWidth()
		original_height = $(selector).innerHeight()
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
				$(selector).val(new_value)
		#this is what happens when the user clicks away from the input box
		$("#popup-input").blur =>
			$("#blacken-input").remove()
			$("#popup-input").remove()


	get_type: () =>
		"helper"

	# cb takes in a winner, if no winner, call it anyway with no parameter
	run: (item)=>
		if not @num_likes?
			console.log $(".likes-input").val()
			@num_likes = parseInt($(".likes-input").val())
		likes = item.likes.count

		if likes >= @num_likes
			return true
		return false

	filter_items: () =>
		#what_filter
		temp_list = $(".draggable.What")
		i = 0
		while i < temp_list.length
			name = $(temp_list[i]).attr "name"
			block = window["block_#{name}"]
			if name is "instagram_competition"
				# temp_list[i].parentNode.removeChild temp_list[i]
				block.filter_items()
			i++