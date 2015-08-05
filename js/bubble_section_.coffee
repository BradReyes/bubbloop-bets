class @bubble_section_
	###
	Parameters:
		left
		top
		diameter
		bubble_type
	###
	constructor: (@left, @top, @diameter, bubble_type)->
		if not window.bubble_counter?
			window.bubble_counter = -1
		@counter = ++window.bubble_counter
		@bank_visible = false #this means that the bubble bank is not visible
		# @toggle_bank()

		# This is for the block name in the bubble
		@block = null

		# Filters blocks
		@type = "what"
		if @counter is 0 then @type = 'Who'
		if @counter is 1 then @type = 'What'
		if @counter is 2 then @type = 'When'
		if @counter is 3 then @type = 'Where'
		if @counter is 4 then @type = 'Why'

		css = """
			.bubble-section-#{@counter} {
				position: absolute;
				top: #{@top}px;
				left: #{@left}px;
				width: #{@diameter}px;
				height: #{@diameter}px;
				border: 1px black solid;
				background: rgba(255, 255, 255,0.8);
				overflow: hidden;
			}
		"""

		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
			<div class='steps bubble-sections bubble-section-#{@counter} #{@type}' role='bubble_section' type='#{bubble_type}'>
				<div id='bubble-text-#{@counter}'>#{bubble_type}</div>
			</div>
		""").appendTo ".drop-zone"

		# each bubble has an associated drag zone that it uses
		@drag_zone = new control_drag_zone_ 12, 20, 350, 'source', this
		@drag_zone.hide()

		# $(".step-by-step").on 'tap click', =>
		# 	console.log "yeah"

		$(".bubble-section-#{@counter}").on 'tap click', =>
			@toggle_bank()
			# Here is where the drop zone would expand to full screen
			# animations to accomplish this:
			###
			bubble section will expand and become a drop zone
			don't worry about animations yet
			###
			#alert "Tapped #{bubble_type}"
			@expand_section()
		#@drag_zone = new drag_zone_()

	toggle_bank: () =>
		$bank = $(".drag-selector")
		console.log "Called"
		if @bank_visible
			w_height = window.innerHeight
			console.log w_height
			$bank.velocity
				top: w_height + 50
			,
				duration: 1000
				complete: =>
					console.log "Got em"
					# $(".draggable").css
					# 	display: "block"
					$(".draggable").css
						display: "block"
					$bank.css
						display: 'none'
		else #invisible to visible
			w_height = window.innerHeight
			real_height = w_height - 160
			$bank.css
				display: 'block'
			$bank.velocity
				top:  real_height
			,
				duration: 1000
			

		@bank_visible = not @bank_visible

	expand_section: () =>
		@inner_text = $(".bubble-section-#{@counter}").text()

		$("#expand-navigation").velocity
			left: 5
		,
			duration: 1000

		$("#expand-navigation").bind "tap click", =>
			@revert(true)
			@toggle_bank()

		$(".bubble-sections:not(.bubble-section-#{@counter})").velocity "fadeOut",
			duration: 1000
		$("#build_button").velocity "fadeOut",
			duration: 1000

		$(".bubble-section-#{@counter}").velocity
			width: 350
			height: 350
			top: 20
			left: 12
		,
			duration: 1000
			complete: =>
				if not @drag_zone.is_filled()
					$(".bubble-section-#{@counter}").css
						visibility: 'hidden'
					@drag_zone.show()

		$("#bubble-text-#{@counter}").velocity "fadeOut",
			duration: 500
			complete: =>
				$("#bubble-text-#{@counter}").text "Drag Here"
				$("#bubble-text-#{@counter}").velocity "fadeIn",
					duration: 500

		$(".draggable:not(.#{@type})").css
			display: "none"

		items = $(".#{@type}.draggable") 
		# @find_closest_to_left $(".#{@type}.draggable") 

		i=0
		while i < items.length
			pos = items[i].getBoundingClientRect()
			s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth/1.2)
			s2 = 1 - Math.abs(s2)

			$(items[i]).css
				'-webkit-transform': "scale(#{s2})"
			++i


	revert: (back_button) =>
		@drag_zone.hide()
		console.log "Going back"
		$("#expand-navigation").unbind()
		$("#expand-navigation").velocity
			left: -110
		,
			duration: 500
		
		# safeguard against multiple things
		if @drag_zone.is_filled()
			$(".bubble-section-#{@counter}").html $(".dragged-block-#{@drag_zone.get_id()}").html()
			console.log $(".dragged-block-#{@drag_zone.get_id()}").html()

			img_value = $(".dragged-block-#{@drag_zone.get_id()}").css("background-image")
			size_value = $(".dragged-block-#{@drag_zone.get_id()}").css("background-size")
			repeat_value = $(".dragged-block-#{@drag_zone.get_id()}").css("background-repeat")
			position_value = $(".dragged-block-#{@drag_zone.get_id()}").css("background-position")

			# background-image: url(http://images.clipartpanda.com/map-clip-art-treasure-map4.png);
			# 	background-size: 110px 110px;
			# 	background-repeat: no-repeat;
			# 	background-position: 25px 20px;

			$(".bubble-section-#{@counter}").css
				'background-image': img_value
				'background-size': size_value
				'background-position': position_value
				'background-repeat': repeat_value

		else
			# $(".bubble-section-#{@counter}").text @inner_text
			$("#bubble-text-#{@counter}").velocity "fadeOut",
			duration: 500
			complete: =>
				$("#bubble-text-#{@counter}").text @inner_text
				$("#bubble-text-#{@counter}").velocity "fadeIn",
					duration: 500

		$(".dragged-block-#{@drag_zone.get_id()}").css
			display: 'none'
		$(".bubble-section-#{@counter}").css
			visibility: 'visible'
		$(".bubble-section-#{@counter}").velocity
			width: @diameter
			height: @diameter
			top: @top
			left: @left
		,
			duration: 1000
		$(".bubble-sections:not(.bubble-section-#{@counter})").velocity "fadeIn",
			duration: 1000
		$("#build_button").velocity "fadeIn",
			duration: 1000

		items = $(".draggable") 
		
		i=0
		while i < items.length
			pos = items[i].getBoundingClientRect()
			s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth/1.2)
			s2 = 1 - Math.abs(s2)

			$(items[i]).css '-webkit-transform': "scale(#{s2})"
			++i

	# THIS IS CALLED IN CONTROL_AREA TO GET THE NAME OF
	# THE BLOCKS
	block_name: () =>
		@drag_zone.get_name()

