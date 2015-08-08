class @control_drag_zone_

	constructor: (left, top, diameter, bubble_type, section)->
		@counter_id = window.counter
		window.counter = @counter_id + 1
		@left = left
		@top = top
		@diameter = diameter
		@bubble_type = bubble_type
		@section = section
		@filled = false
		@block_name = null

		css = """
			.droppable-#{@counter_id} {
				position: absolute;
				top: #{top}px;
				left: #{left}px;
				width: #{diameter}px;
				height: #{diameter}px;
				border: 1px black solid;
				background: rgba(255, 255, 255, 0.8);
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$(".#{@bubble_type}").css
			opacity: 1

		# Fade out invalid bubbles
		# inValid_bubbles = $(".draggable:not(.#{@bubble_type})")
		# inValid_bubbles.css
		# 	opacity: .1

		append_to_this = null
		if $target?
			append_to_this = $target
		else append_to_this = '.drop-zone'

		$("""
		<div id='celeb-drop-zone' class='droppable steps droppable-#{@counter_id}' role='condition'>
			<!--Drag Here-->
		</div>
		""").appendTo ".drop-zone"

		# Block bank UI
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

		# still double fillable
		# interact('.droppable:not(.caught--it)').dropzone
		interact(".droppable-#{@counter_id}").dropzone
			accept: '.draggable'
			overlap: .1

			ondropactivate: (event) ->
				$target = $ event.target
				$target.addClass 'can--drop'
				# $target.addClass 'can--catch'
				# $target.addClass 'drop--me'

			ondragenter: (event) ->
				$draggableElement = $ event.relatedTarget
				dropzoneElement = event.target
				$dropzoneElement = $ event.target
				dropRect = interact.getElementRect dropzoneElement
				dropCenter =
					x: dropRect.left + dropRect.width / 2
					y: dropRect.top + dropRect.height / 2
				# event.draggable.draggable
				# 	snap:
				# 		targets: [ dropCenter ]

				# feedback the possibility of a drop
				dropzoneElement.classList.add 'can--catch'
				$draggableElement.addClass 'drop--me'
				$dropzoneElement.css
					overflow: 'hidden'


			ondragleave: (event) ->
				# remove the drop feedback style
				$target = $ event.target
				$relatedTarget = $ event.relatedTarget
				$target.removeClass 'can--catch'
				$relatedTarget.removeClass 'caught--it'
				$relatedTarget.removeClass 'drop--me'

			ondrop: (event) =>
				$target = $ event.target
				$related_target = $ event.relatedTarget
				$target.css
					position: 'relative'


				# This encapsulates the logic
				block_name = $related_target.attr "name"
				# gets from DOM so that we can use the block
				@block = window["block_#{block_name}"]
				@filled = true
				@block_name = block_name

				$target.removeClass 'can--catch'

				# x = $related_target.offset().left
				# y = $related_target.offset().top
				block_offset = $related_target.offset()
				zone_offset = $target.offset()

				# CLONE LOGIC
				if $related_target.hasClass('drag-wrap')
					# clone and append to drop zone
					x = $related_target.offset().left
					y = $related_target.offset().top
					real_diameter = $related_target.width()
					$clone = $related_target.detach() #block
					$clone.removeClass 'drag-wrap'
					$clone.removeClass 'getting--dragged'
					$clone.removeClass 'draggable'
					$clone.addClass 'not-draggable'
					# $clone.appendTo '.drop-zone' #this is old 
					$clone.removeClass @bubble_type

					console.log zone_offset
					console.log block_offset
					relative_left = block_offset.left - zone_offset.left
					relative_top = block_offset.top - zone_offset.top
					console.log """
						Left: #{relative_left}
						Top: #{relative_top}
					"""
					x = relative_left
					y = relative_top
					$clone.css
						'-webkit-transform': "translate(#{x}px, #{y}px)"
						position: 'absolute'
						# top: y
						# left: x
						opacity: 1
						width: "#{real_diameter}"
						height: "#{real_diameter}"
						'z-index': 5000

					$clone.appendTo $target

					# block_offset = $related_target.offset()
					# zone_offset = $target.offset()

					###
					We need to append the cloned object to 
					the drop zone, not the dropzone in general.
					Then we can copy the innerHTML from the drop zone and 
					paste that to the bubble_section object it's associated with
					###

					#THIS IS NEW LOGIC!!!
					$clone.addClass "dragged-block-#{@counter_id}"
					console.log "dragged-block-#{@counter_id}"

					# This complicates everything
					#$clone.addClass "droppable-#{@counter_id}"

					# update position attributes
					# x = $target.position().left + 10
					# y = $target.position().top + 10
					$clone.attr 'data-x', x
					$clone.attr 'data-y', y

					# original dropzone disappear
					# $target.css
					# 	opacity: 0

					# remove all bubbles of current type
					# $(".#{@bubble_type}").remove()

					# update bank
					items = $ ".drag-wrap"
					onScroll()
					# @section.revert($clone)
					# @section.toggle_bank()
					#window.control.expand(block_name)

			ondropdeactivate: (event) ->
				$target = $ event.target
				$target.removeClass 'can--drop', 'can--catch'

	run: (name, cb)=>
		@block.run name, cb

	hide: () =>
		$(".droppable-#{@counter_id}").css
			display: 'none'

	show: () =>
		$(".droppable-#{@counter_id}").css
			display: 'block'

	get_selector: () =>
		selector = ".droppable-#{@counter_id}"
		selector

	get_id: () =>
		@counter_id

	is_filled: () =>
		@filled

	get_name: () =>
		return_value = 
			block_name: @block_name
			block: @block
