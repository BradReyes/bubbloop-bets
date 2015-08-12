class @block_gmail_

	constructor: ()->
		css = """
		[name=gmail] {
			background-image: url(img/Gmail-icon.png);
			background-size: cover;
		}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable action Why" name="gmail">
		</div>
		""").appendTo ".drag-zone"

		

	# constructs an array to pass back to the list
	run: (images) =>
		images = images[0]
		if images.images isnt undefined
			#instagram
			url = images.images.standard_resolution.url
			title = images.caption.text

		#twitter
		else if images.entities.media isnt undefined 
			url = images.entities.media[0].media_url 
			title = images.text
		else
			url = images.user.profile_image_url
			length = images.user.profile_image_url.length
			if url[url.length-2] is "e" 
				url = url[0...url.length - 12] + ".jpeg"
			else
				url = url[0...url.length - 11] + ".jpg"
			title = images.text

		$.ajax
			url: "/gmail?content=<img src = " + url + ">&title=" + title;
			dataType: 'json'
			type: "GET"
			error: (jqXHR, textStatus, errorThrown) ->
			success: (data, textStatus, jqXHR) ->

	filter_items: () =>
		#what_filter
		temp_list = $(".draggable.What")
		i = 0
		while i < temp_list.length
			name = $(temp_list[i]).attr "name"
			block = window["block_#{name}"]
			if name is "instagram_competition"
				block.filter_items()
			i++