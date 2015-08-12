class @block_display_image_

	constructor: ()->
		css = """
			.display-image-text {
				position: absolute;
				top: 6px;
				left: 4px;
				color: blue;
				font-weight: bold;
			}

			.display-image-icon {
				position: absolute;
				top: 25px;
				left: 20px;
				color: grey;
			}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div style='overflow: visible' class="drag-wrap draggable action Why block_display_image_" name="display_image">
			<i class="fa fa-picture-o fa-5x display-image-icon"></i>
			<p class='display-image-text'>DISPLAY IMAGE</p>
		</div>
		""").appendTo ".drag-zone"

	run: (list) =>
		async.forEachOfSeries list, (element, i, cb) =>
			@display_individual_image element, cb
		, (err) ->
			alert "all done"

	display_individual_image: (obj, cb) =>
		url = obj.images.standard_resolution.url
		$('<div id="white-background"></div><div id="image-div"></div><img class="new_image" src='+url+' />').appendTo "body"

		$('#white-background').css
			backgroundColor: 'white'
			backgroundSize: 'cover'
			backgroundPosition: 'center'
			position: 'fixed'
			margin: 0
			top: 0
			bottom: 0
			right: 0
			left: 0
			width: '100%'
			height: '100%'
			zIndex: 10000000

		$('#image-div').css
			backgroundImage:"url(#{url})"
			backgroundSize:'cover'
			backgroundPosition:'center'
			position:'fixed'
			margin: 0
			top: '-50%'
			bottom: 0
			right: 0
			left:'-50%'
			width : '200%'
			height : '200%'
			zIndex: 10000001
			opacity: 0.35
			transform: 'rotate(15deg)'

		$('.new_image').css
			maxWidth: '120%'
			maxHeight: '100%'
			bottom: 0
			left: 0
			margin: 'auto'
			overflow: 'auto'
			position: 'fixed'
			right: 0
			top: 0
			zIndex: 10000002

		setTimeout cb, 2000

	filter_items: () => #obtains the list of who objects current available, removing those without instagram_id 
		what_list = $(".draggable.What")

		j = 0 
		while j < what_list.length
			name = $(what_list[j]).attr "name"
			what_block = window["block_#{name}"]
			if name is "instagram_competition"
				what_block.filter_items()
			j++