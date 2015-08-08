class @block_display_image_

	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable action Why" name="display_image">
			DISPLAY IMAGE
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