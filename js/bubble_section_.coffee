###
bubble_section_
------------------
creates an drop_zone that expands and keeps track
of every block dropped in its respective zone

Although each zone has a run() method, the functionality of
each run method is actually different depending on the bubble_type 
passed in: who, what, when, where, why; 

Parameters:
	left: the position from the left
	top: position from the top
	diameter: the diameter of the bubble
	bubble_type: who, what, when, where or why
###

class @bubble_section_

	# creates the look of the bubbles and initialized the drop zone
	constructor: (@left, @top, @diameter, @type)->
		@counter_id = ++window.counter #makes sure each section is unique

		# Initializes the fact that te bank is invisible to start and
		# that there's nothing in the block list
		@bank_visible = false
		@block_list = []

		css = """
			.droppable-#{@counter_id} {
				position: absolute;
				top: #{@top}px;
				left: #{@left}px;
				width: #{@diameter}px;
				height: #{@diameter}px;
				border: 1px black solid;
				background: rgba(255, 255, 255, 0.8);
				
			}

			.droppable-inner-#{@counter_id} {
				width: 100%;
				height: 100%;
				border-radius: 100px;
				position: relative;
				
			}

			.text-middle-#{@counter_id} {
				color: black;
				position: absolute;

			}
		
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class='drag-zones droppable steps droppable-#{@counter_id}' role='condition'>
			<p class='text-middle-#{@counter_id}'>#{@type}</p>
			<div class='droppable-inner-#{@counter_id}'></div>
		</div>
		""").appendTo ".drop-zone"

		###
		The following is to get the text in the bubble zone
		to show up in the middle
		###
		half_width_text = $(".text-middle-#{@counter_id}").width() / 2
		half_width_bubble = @diameter / 2
		x_pos_text = half_width_bubble - half_width_text
		half_height_text = $(".text-middle-#{@counter_id}").height() / 2
		y_pos_text = half_width_bubble - half_height_text - 30

		# Initializes the text positio from top and left for future animations
		@text_x = x_pos_text
		@text_y = y_pos_text
		$(".text-middle-#{@counter_id}").css
			left: @text_x
			top: @text_y

		# Make bubble section clickable to toggle
		interact(".droppable-#{@counter_id}")
		.on 'tap', (event) =>
			@toggle_bank()
			@expand_section()

		# add dropzone here
		@add_dropzone()

	# Manually set a block to put in the drop zone
	set_block: (item) =>
		@block_list.push item

	# helper method
	bubble_is_empty: () =>
		return (@block_list.length <= 0) or (@block_list is null) or (@block_list is undefined)

	###
	Run: 
	changes functionality depending 
	on what type of bubbles section this is
	that's why params are so general and undescriptive
	###
	run:(param1, param2, param3) =>
		switch @type
			when 'What'
				@run_what param1, param2, param3
			when 'When'
				@run_when param1
			when 'Where'
				@run_where()
			when 'Why'
				@run_why param1, param2, param3
			when 'Who'
				@run_who()

	###
	The following runs the specific instances for the
	blocks
	###

	# Returns a list of all the blocks in who
	# will return empty list of nobody is specified
	run_who: () =>
		lists = []
		for block in @block_list
			lists.push block.run()
		lists

	# Gets called, runs functions (cb) that it's given 
	# at the specified time given
	run_when: (cb) =>
		if @bubble_is_empty()
			cb()
			return
		start_block = false
		for block in @block_list
			if block.get_type() is "start"
				start_block = true
			block.run cb

		# if there's no start block, then
		# run the program immediately
		if start_block is false
			cb()

	run_where: () =>
		locations = []
		for block in @block_list
			locations.push block.run()
		locations

	# info from what's returned from what
	# such as image from instagram
	# can be ignored if wanted
	run_why: (info) =>
		for block in @block_list
			block.run info

	###
	run_what can have action object and helper ones
	###
	run_what: (who_list, locations, action) =>
		if @bubble_is_empty() #run action immediately
			action who_list, locations
			return
		main_block = false
		store_main_block = null # need to find main_block
		counter = 0
		what_blocks = []
		# loop through all the blocks in the block list
		for block in @block_list
			console.log what_blocks
			console.log block
			block_type = block.get_type()
			if block_type is "action"
				# can't have two main_blocks
				if main_block is true
					alert "What blocks don't match up correctly"
					return
				main_block = true
				store_main_block = block
			else what_blocks.push block

			counter++
		if store_main_block is null
			alert "What blocks don't include a main action"
			return
		# perhaps move elsewhere
		$(".step-by-step").remove()
		$("#build_button").remove()
		store_main_block.run who_list, locations, action, what_blocks


	# adds the dropzone
	add_dropzone: () =>
		#for the bank
		items = $ ".drag-wrap"
		onScroll = ()=>
			i=0
			while i < items.length
				pos = items[i].getBoundingClientRect()
				s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth/1.2)
				s2 = 1 - Math.abs(s2)

				$(items[i]).css
					'-webkit-transform': "scale(#{s2})"
				++i
			return

		# dropzone logic
		interact(".droppable-#{@counter_id}").dropzone
			accept: '.draggable'
			overlap: .1

			ondropactivate: (event) ->
				$target = $ event.target
				$target.addClass 'can--drop'

			ondragenter: (event) ->
				$draggableElement = $ event.relatedTarget
				dropzoneElement = event.target
				dropRect = interact.getElementRect dropzoneElement
				dropCenter =
					x: dropRect.left + dropRect.width / 2
					y: dropRect.top + dropRect.height / 2
				dropzoneElement.classList.add 'can--catch'
				$draggableElement.addClass 'drop--me'
				
			ondragleave: (event) ->
				$target = $ event.target
				$relatedTarget = $ event.relatedTarget
				$target.removeClass 'can--catch'
				$relatedTarget.removeClass 'caught--it'
				$relatedTarget.removeClass 'drop--me'

			ondrop: (event) =>
				$target = $ event.target
				$related_target = $ event.relatedTarget
				block_name = $related_target.attr "name"

				# gets from DOM so that we can use the block
				@block = window["block_#{block_name}"]
				@block_list.push @block

				@block_name = block_name
				$target.removeClass 'can--catch'

				block_offset = $related_target.offset()
				zone_offset = $target.offset()

				# CLONE LOGIC
				if $related_target.hasClass('drag-wrap')
					real_diameter = $related_target.width()
					$clone = $related_target.detach() #block
					$clone.removeClass 'drag-wrap'
					$clone.removeClass 'getting--dragged'
					$clone.removeClass 'draggable'
					$clone.addClass 'not-draggable'
					$clone.removeClass @bubble_type

					relative_left = block_offset.left - zone_offset.left
					relative_top = block_offset.top - zone_offset.top
					x = relative_left + 10
					y = relative_top + 10

					$clone.css
						'-webkit-transform': "translate(#{0}px, #{0}px)"
						top: "#{parseInt(y)}px"
						left: "#{parseInt(x)}px"
						position: 'absolute'
						opacity: 1
						width: "#{real_diameter}"
						height: "#{real_diameter}"
						'z-index': 5000

					$clone.prependTo $(".droppable-inner-#{@counter_id}")

					$clone.attr 'data-x', x
					$clone.attr 'data-y', y

					# update bank
					items = $ ".drag-wrap"
					onScroll()

					# filters the blocks
					if @block.filter_items
						@block.filter_items() 

			ondropdeactivate: (event) ->
				$target = $ event.target
				$target.removeClass 'can--drop', 'can--catch'

	# toggles the bank on the bottom of the screen
	toggle_bank: () =>
		$bank = $(".drag-selector")
		if @bank_visible
			@bank_visible = not @bank_visible
			w_height = window.innerHeight
			
			$bank.velocity
				top: w_height + 50
			,
				duration: 1000
				complete: =>
					$(".draggable").css
						display: "block"
					$bank.css
						display: 'none'
		else #invisible to visible
			@bank_visible = not @bank_visible
			w_height = window.innerHeight
			real_height = w_height - 160
			$bank.css
				display: 'block'
			$bank.velocity
				top:  real_height
			,
				duration: 1000

	# expand bubble
	expand_section: () =>

		# since bubbles are bigger than circles, only show
		# overflow a little after bubbles start moving
		setTimeout =>
			$(".droppable-#{@counter_id}").css
				overflow: 'visible'
		, 100

		# back button logic
		$("#expand-navigation").velocity
			left: 5
		,
			duration: 1000
		$("#expand-navigation").bind "tap click", =>
			@revert()
			@toggle_bank()

		# fade out everything except the thing we are expanding
		$(".drag-zones:not(.droppable-#{@counter_id})").velocity "fadeOut",
			duration: 1000

		# get rid of the build button as well
		$("#build_button").velocity "fadeOut",
			duration: 1000

		# get rid of random button
		$(".random_button").velocity "fadeOut",
			duration: 1000
		$(".random_area").velocity "fadeOut",
			duration: 1000

		# expand the bubble section to take up entire screen
		$(".droppable-#{@counter_id}").velocity
			width: 350
			height: 350
			top: 20
			left: 12
		,
			duration: 1000

		# animation for the text inside the bubble
		$("#bubble-text-#{@counter}").velocity "fadeOut",
			duration: 500
			complete: =>
				$("#bubble-text-#{@counter}").text "Drag Here"
				$("#bubble-text-#{@counter}").velocity "fadeIn",
					duration: 500

		# get rid of everything that's not related to the current bubble section
		$(".draggable:not(.#{@type})").css
			display: "none"

		# animates all the bubbles in the block_list
		$(".droppable-inner-#{@counter_id}").children().each (index) ->
			$cur_child = $(this)
			x_coord = $cur_child.attr "data-x"
			y_coord = $cur_child.attr "data-y"
			$(this).velocity
				top: y_coord
				left: x_coord
				opacity: 1
			,
				duration: 1000

		# text animation to disappear
		$(".text-middle-#{@counter_id}").velocity
			left: 150
			opacity: 0
		,
			duration: 1000

		# this fixes the block bank
		items = $(".#{@type}.draggable")

		i=0
		while i < items.length
			pos = items[i].getBoundingClientRect()
			s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth/1.2)
			s2 = 1 - Math.abs(s2)

			$(items[i]).css
				'-webkit-transform': "scale(#{s2})"
			++i

		# unbind the tap event to the drag zone
		interact(".droppable-#{@counter_id}").unset()
		# since the previous thing unbinds everything, 
		# we need to re-add the dropzone
		@add_dropzone()

	# shrink dragzone back down
	revert: () =>
		# makes text appear again
		$(".text-middle-#{@counter_id}").css
			top: @text_y
			left: @text_x

		# makes back button disappear
		$("#expand-navigation").unbind()
		$("#expand-navigation").velocity
			left: -110
		,
			duration: 500

		# since bubbles are bigger than the shrunken section,
		# make overflow hidden before it reaches point of
		# intersection
		setTimeout =>
			$(".droppable-#{@counter_id}").css
				overflow: 'hidden'
		, 800

		# shrinks the drop zone to normal size
		$(".droppable-#{@counter_id}").velocity
			width: @diameter
			height: @diameter
			top: @top
			left: @left
		,
			duration: 1000

		# makes other drop-zones that disappeared appear
		$(".drag-zones:not(.droppable-#{@counter_id}").velocity "fadeIn",
			duration: 1000

		# build button appears
		$("#build_button").velocity "fadeIn",
			duration: 1000

		# make text fade in over 1 second
		$(".text-middle-#{@counter_id}").velocity
			opacity: 1
		,
			duration: 1000

		# random button appears again
		$(".random_button").velocity "fadeIn",
			duration: 1000
		$(".random_area").velocity "fadeIn",
			duration: 1000

		# fixes bank
		items = $(".draggable") 
		
		i=0
		while i < items.length
			pos = items[i].getBoundingClientRect()
			s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth/1.2)
			s2 = 1 - Math.abs(s2)

			$(items[i]).css '-webkit-transform': "scale(#{s2})"
			++i

		# animation for the elements inside a spcific 
		# dropzone
		$(".droppable-inner-#{@counter_id}").children().each (index) ->
			# console.log 
			$(this).velocity
				left: 0
				top: 0
				opacity: 0.2
			,
				duration: 1000

		# re-adds click event to expand
		interact(".droppable-#{@counter_id}")
		.on 'tap', (event) =>
			@toggle_bank()
			@expand_section()