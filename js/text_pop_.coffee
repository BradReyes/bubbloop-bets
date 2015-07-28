class @text_pop_

	@text_counter: 0

	constructor: (@div_id)->
		@input_id = @text_counter++
		@input_id

		interact("##{div_id}")
		.on 'tap', (event) =>
			event.preventDefault()
			$("#hashtag_input#{@counter}").focus()
			@expand()


	get_text: ()=>

###
		interact("[name=hashtag]")
		.on 'tap', (event) =>
			event.preventDefault()
			$("#hashtag_input#{@counter}").focus()
			@expand()


	blacken_background: () =>
		$blacken = $ "<div>",
			id: 'blacken-input'
		.css
			zIndex: 500
			backgroundColor: 'rgba(0,0,0,0.5)'
			width: '100%'
			height: '100%'
			position: 'absolute'
			left: 0
			top: 0

		$("body").prepend $blacken
		$blacken.bind 'tap touchstart', ->
			$("#popup-input").blur()
			$("#popup-input").remove()
			$("#blacken-input").remove()

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
				$("#popup-input").remove()
				$("#blacken-input").remove()
			else
				new_value = $("#popup-input").val()
				# console.log new_value
				$("#hashtag_input#{@counter}").val(new_value)
		#this is what happens when the user clicks away from the input box
		$("#popup-input").blur =>
			$("#popup-input").remove()
			$("#blacken-input").remove()
###