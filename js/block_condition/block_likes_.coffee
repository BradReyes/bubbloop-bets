class @block_likes_

	constructor: ()->
		css = """
			#likes-input{
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
		<div class="drag-wrap draggable filter" name="likes">
			LIKES
			<input id="likes-input" type="text" value="">
		</div>
		""").appendTo ".drag-zone"

		interact("#likes-input")
		.on 'tap', (event) =>
			event.preventDefault()
			$("#likes-input").focus()
			@expand("#likes-input")

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


	# cb takes in a winner, if no winner, call it anyway with no parameter
	run: (competitors, cb)=>
		if not @num_likes?
			console.log $("#likes-input").val()
			@num_likes = parseInt($("#likes-input").val())
		console.log @num_likes
		player1 = competitors.first_val
		player2 = competitors.second_val
		# players are array with [0] = the id and [1] is the actual pic
		player1_likes = player1[1].likes.count
		player2_likes = player2[1].likes.count
		$("#instagram-matchup-counter-1").text "LIKES: #{player1_likes}"
		$("#instagram-matchup-counter-2").text "LIKES: #{player2_likes}"
		$("#put-goal-here").text @num_likes

		if player1_likes >= @num_likes
			cb competitors.first_val[1], true
		else if player2_likes >= @num_likes
			cb competitors.second_val[1], false
		else
			cb()
