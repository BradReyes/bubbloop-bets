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

		css = """
			.bubble-section-#{@counter} {
				position: absolute;
				top: #{@top}px;
				left: #{@left}px;
				width: #{@diameter}px;
				height: #{@diameter}px;
				border: 1px black solid;
				background: rgba(255, 255, 255,0.8);
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
			<div class='steps bubble-sections bubble-section-#{@counter}' role='bubble_section' type='#{bubble_type}'>
				<div id='bubble-text-#{@counter}'>#{bubble_type}</div>
			</div>
		""").appendTo ".drop-zone"

		# each bubble has an associated drag zone that it uses
		@drag_zone = new control_drag_zone_ 12, 20, 350, 'source', this
		@drag_zone.hide()

		# $(".step-by-step").on 'tap click', =>
		# 	console.log "yeah"

		$(".bubble-section-#{@counter}").on 'tap click', =>
			# Here is where the drop zone would expand to full screen
			# animations to accomplish this:
			###
			bubble section will expand and become a drop zone
			don't worry about animations yet
			###
			#alert "Tapped #{bubble_type}"
			@expand_section()
		#@drag_zone = new drag_zone_()

	expand_section: () =>
		# $("body").on 'click', =>
		# 	alert "yeah"
		$(".bubble-sections:not(.bubble-section-#{@counter})").velocity "fadeOut",
			duration: 1000
			# complete: =>
			# 	$(".bubble-sections").velocity "fadeIn",
			# 		duration: 5000
		$(".bubble-section-#{@counter}").velocity
			width: 350
			height: 350
			top: 20
			left: 12
		,
			duration: 1000
			complete: =>
				$(".bubble-section-#{@counter}").css
					visibility: 'hidden'
				@drag_zone.show()

		console.log $("#bubble-text-#{@counter}")[0]
		$("#bubble-text-#{@counter}").velocity "fadeOut",
			duration: 500
			complete: =>
				$("#bubble-text-#{@counter}").text "Drag Here"
				$("#bubble-text-#{@counter}").velocity "fadeIn",
					duration: 500

	revert: () =>
		@drag_zone.hide()
		console.log "Going back"
		# console.log $(".dragged-block-#{@drag_zone.get_id()}").html()

		# $(".bubble-section-#{@counter}")[0].outerHTML = $(".dragged-block-#{@drag_zone.get_id()}")[0].outerHTML
		$(".bubble-section-#{@counter}").html $(".dragged-block-#{@drag_zone.get_id()}").html()
		console.log $(".dragged-block-#{@drag_zone.get_id()}").html()

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



	# 	@counter_id = window.counter
	# 	window.counter = @counter_id + 1
	# 	@left = left
	# 	@top = top
	# 	@diameter = diameter
	# 	@bubble_type = bubble_type

	# 	css = """
	# 		.droppable-#{@counter_id} {
	# 			position: absolute;
	# 			top: #{top}px;
	# 			left: #{left}px;
	# 			width: #{diameter}px;
	# 			height: #{diameter}px;
	# 			border: 1px black solid;
	# 			background: rgba(255, 255, 255, 0.8);
	# 		}
	# 	"""
	# 	$("<style type='text/css'></style>").html(css).appendTo "head"

	# 	$(".#{@bubble_type}").css
	# 		opacity: 1

	# 	# Fade out invalid bubbles
	# 	inValid_bubbles = $(".draggable:not(.#{@bubble_type})")
	# 	inValid_bubbles.css
	# 		opacity: .1

	# 	append_to_this = null
	# 	if $target?
	# 		append_to_this = $target
	# 	else append_to_this = '.drop-zone'

	# 	$("""
	# 	<div id='celeb-drop-zone' class='droppable steps droppable-#{@counter_id}' role='condition'>
	# 	</div>
	# 	""").appendTo ".drop-zone"

	# 	# Block bank UI
	# 	items = $ ".drag-wrap"
	# 	onScroll = ()=>
	# 		i=0
	# 		while i < items.length
	# 			pos = items[i].getBoundingClientRect()
	# 			s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth/1.2)
	# 			s2 = 1 - Math.abs(s2)

	# 			$(items[i]).css
	# 				'-webkit-transform': "scale(#{s2})"
	# 			++i
	# 		return

	# 	# still double fillable
	# 	# interact('.droppable:not(.caught--it)').dropzone
	# 	interact(".droppable-#{@counter_id}").dropzone
	# 		accept: '.draggable'
	# 		overlap: .1

	# 		ondropactivate: (event) ->
	# 			$target = $ event.target
	# 			$target.addClass 'can--drop'
	# 			# $target.addClass 'can--catch'
	# 			# $target.addClass 'drop--me'

	# 		ondragenter: (event) ->
	# 			$draggableElement = $ event.relatedTarget
	# 			dropzoneElement = event.target
	# 			dropRect = interact.getElementRect dropzoneElement
	# 			dropCenter =
	# 				x: dropRect.left + dropRect.width / 2
	# 				y: dropRect.top + dropRect.height / 2
	# 			event.draggable.draggable
	# 				snap:
	# 					targets: [ dropCenter ]

	# 			# feedback the possibility of a drop
	# 			dropzoneElement.classList.add 'can--catch'
	# 			$draggableElement.addClass 'drop--me'

	# 		ondragleave: (event) ->
	# 			# remove the drop feedback style
	# 			$target = $ event.target
	# 			$relatedTarget = $ event.relatedTarget
	# 			$target.removeClass 'can--catch'
	# 			$relatedTarget.removeClass 'caught--it'
	# 			$relatedTarget.removeClass 'drop--me'

	# 		ondrop: (event) =>
	# 			$target = $ event.target
	# 			$related_target = $ event.relatedTarget

	# 			# This encapsulates the logic
	# 			block_name = $related_target.attr "name"
	# 			@block = window["block_#{block_name}"]


	# 			# CLONE LOGIC
	# 			if $related_target.hasClass('drag-wrap')
	# 				# clone and append to drop zone
	# 				$clone = $related_target.detach()
	# 				$clone.removeClass 'drag-wrap'
	# 				$clone.removeClass 'getting--dragged'
	# 				$clone.removeClass 'draggable'
	# 				$clone.addClass 'not-draggable'
	# 				$clone.appendTo '.drop-zone'
	# 				$clone.removeClass "#{@bubble_type}"

	# 				# update position attributes
	# 				x = $target.position().left + 10
	# 				y = $target.position().top + 10
	# 				$clone.css
	# 					'-webkit-transform': "translate(#{x}px, #{y}px)"
	# 					position: 'absolute'
	# 					opacity: 0.4
	# 					width: diameter
	# 					height: diameter
	# 				$clone.attr 'data-x', x
	# 				$clone.attr 'data-y', y

	# 				# original dropzone disappear
	# 				$target.css
	# 					opacity: '0'

	# 				# remove all bubbles of current type
	# 				$(".#{@bubble_type}").remove()

	# 				# update bank
	# 				items = $ ".drag-wrap"
	# 				onScroll()

	# 				window.control.expand(block_name)

	# 		ondropdeactivate: (event) ->
	# 			$target = $ event.target
	# 			$target.removeClass 'can--drop', 'can--catch'

	# run: (name, cb)=>
	# 	@block.run name, cb