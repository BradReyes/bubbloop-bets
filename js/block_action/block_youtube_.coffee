class @block_youtube_

	constructor: ()->
		css = """
		#youtube_pic{
			position: absolute;
			left: 20px;
			top: 25px;
			width: 100px;
			height: 100px;
		}

		#youtube_player {
			position: absolute;
			top: 0px;
			left: -144px;
		}

		"""

		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable Why" name="youtube">
			<div id="youtube_player"></div>
			<img id="youtube_pic" src="img/youtube-logo.png">
		</div>
		""").appendTo ".drag-zone"

	# takes in a list of people passed in
	run: (people) =>
		if people.length <= 0
			alert "Need someone to search"
			return
		complete_query = ""
		for celeb in people
			complete_query += "#{celeb.name} "
		@search encodeURIComponent(complete_query), (videos) =>
			#what to do with the videos now
			video = videos[0] # takes the first video
			$("body").html " "
			$youtube = $("""
				<iframe title='Youtube' width='100%' height='100%'
				src='#{video.source}' frameborder='0' allowfullscreen>
				</iframe>
			""")
			$youtube.appendTo $("body")


	# Takes in a search query and a callback
	# the callback takes in an array of video objects
	search: (query, cb) =>
		YT_URL = 'https://www.googleapis.com/youtube/v3/search'
		YT_API_KEY = 'AIzaSyDDP01Gnj3-wfoqM59xQz6pryJQhmYWCt8'
		# YT_API_KEY = 'AIzaSyDIBsEcwPfptc_THmUtO5OhU5BV6KLqFs'
		YT_EMBED_URL = 'http://www.youtube.com/embed/'
		getURL = YT_URL + "?key=" + YT_API_KEY + "&q=" + query + "&part=snippet&type=value"

		$.ajax
			method: "GET"
			url: getURL
		.done (body, response, error)=>
			# videos = JSON.parse(body).items
			videos = body.items
			console.log videos
			video_objects = []
			videos.forEach (cur)=>
				if cur.id.videoId?
					video_objects.push
						'title': cur.snippet.title,
						'source': YT_EMBED_URL + cur.id.videoId + "?autoplay=1"
			cb video_objects

	filter_items: () => #obtains the list of who objects current available, removing those without instagram_id 
		what_list = $(".draggable.What")
		who_list = $(".draggable.Who")

		# get rid of every what block
		i = 0 
		while i < what_list.length
			name = $(what_list[i]).attr "name"
			$cur = $("div[name='#{name}']")
			$cur.remove()
			i++


		j = 0 
		while j < who_list.length
			name = $(who_list[j]).attr "name"
			$cur = $("div[name='#{name}']")
			if not ($cur.hasClass "celebrity")
				$cur.remove()
			j++
