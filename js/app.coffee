$ ->

	window.counter = -1 # this is to separate logic between conditions

	# $('html').on "click", (e)=>
	# 	console.log "yo"
	# 	console.log e.target
	# 	console.log e

	# -----------------------------
	# BLOCKS (bank layout 9-8-9)
	# -----------------------------
	# Step 1 - Celeb
	# ic = new instagram_competition_ "dr.bradass", "emsandy2", 2

	# window.block_picture = new block_picture_()
	# window.block_geocaching = new block_geocaching_()
	window.block_instagram_competition = new block_instagram_competition_()
	window.block_my_location = new block_my_location_()
	window.block_taylorswift = new block_taylorswift_()
	window.block_beyonce = new block_beyonce_()
	window.block_drake = new block_drake_()
	window.block_rihanna = new block_rihanna_()
	window.block_selenagomez = new block_selenagomez_()
	window.block_kimkardashian = new block_kimkardashian_()

	# # Step 2 - Source
	window.block_pizza = new block_pizza_()
	window.block_hoovertower = new block_hoovertower_()
	window.block_dish = new block_dish_()
	window.block_garden = new block_garden_()
	window.block_gates = new block_gates_()
	window.block_goldengatebridge = new block_goldengatebridge_()
	window.block_lawschool = new block_lawschool_()
	window.block_mausoleum = new block_mausoleum_()
	window.block_memorialchurch = new block_memorialchurch_()
	window.block_yogurtland = new block_yogurtland_()
	#window.block_my_location = new block_my_location_()
	# window.block_photos = new block_photos_()
	window.block_likes = new block_likes_()
	window.block_display_image = new block_display_image_()
	window.block_time = new block_time_()
	window.block_time_end = new block_time_end_()
	window.block_youtube = new block_youtube_()
	window.block_ding = new block_ding_()
	window.block_geocaching = new block_geocaching_()
	# window.block_map = new block_map_()
	# window.block_source = new block_source_()
	# window.block_instagram = new block_instagram_()
	# window.block_source = new block_source_()
	# # window.block_spotify = new block_spotify_()
	# # window.block_soundcloud = new block_soundcloud_() # needs work

	# # Step 3 - Filters
	# window.block_hashtag = new block_hashtag_()
	# window.block_caption = new block_caption_()
	# window.block_users_in_photo = new block_users_in_photo_()

	# # Step 4 - Action
	# window.block_display_image_fade = new block_display_image_fade_()
	# window.block_display_image = new block_display_image_()
	# window.block_tinder = new block_tinder_()
	# window.block_play_audio = new block_play_audio_()

	# Control statements
	window.control = new control_drop_area_ ()->
		console.log "DONE"

	# YT_URL = 'https://www.googleapis.com/youtube/v3/search'
	# YT_API_KEY = 'AIzaSyDDP01Gnj3-wfoqM59xQz6pryJQhmYWCt8'
	# # YT_API_KEY = 'AIzaSyDIBsEcwPfptc_THmUtO5OhU5BV6KLqFs'
	# YT_EMBED_URL = 'http://www.youtube.com/embed/'

	# # Test for the youtube api
	# search = (query, cb) =>
	# 	getURL = YT_URL + "?key=" + YT_API_KEY + "&q=" + query + "&part=snippet&type=value"

	# 	$.ajax
	# 		method: "GET"
	# 		url: getURL
	# 	.done (body, response, error)=>
	# 		# videos = JSON.parse(body).items
	# 		videos = body.items
	# 		console.log videos
	# 		video_objects = []
	# 		videos.forEach (cur)=>
	# 			video_objects.push
	# 				'title': cur.snippet.title,
	# 				'source': YT_EMBED_URL + cur.id.videoId
	# 		cb video_objects

	# search "too many cooks", (videos) =>
	# 	console.log videos

	# 'title': cur.snippet.title,
	# 'source': YT_EMBED_URL + cur.id.videoId


	# ---------------------------
	# APPLE WATCH UI BLOCK BANK
	# ---------------------------
	items = document.querySelectorAll(".drag-wrap")

	h = window.innerHeight
	w = window.innerWidth

	# center
	c = items[Math.round(items.length / 2)]
	cr = c.getBoundingClientRect()

	onScroll = ()=>
		i=0
		while i < items.length
			pos = items[i].getBoundingClientRect()
			s2 = (pos.left + pos.width / 2 - (w / 2)) / (w/1.2)
			s2 = 1 - Math.abs(s2)

			$(items[i]).css
				'-webkit-transform': "scale(#{s2})"
			++i
		return

	# set up ui on load
	onScroll cr.left - (w / 2) + cr.width / 2, cr.top - (h / 2) + cr.height / 2



	# ---------------------------------
	# DRAGGABLE GRID (BUBBLE SCROLLING)
	# ---------------------------------
	interact('.drag-zone').draggable
		inertia: true
		restrict:
				restriction: 'body'
				endOnly: true
				elementRect:
					left: 0.80
					right: 0.20
		onstart: (event) ->
		onmove: (event) =>
			$target = $ event.target
			x = (parseFloat($target.attr 'data-x') or 0) + event.dx
			# y = (parseFloat($target.attr 'data-y') or 0) + event.dy

			$target.css
				'-webkit-transform': "translate(#{x}px)"
				# '-webkit-transform': "translate(#{x}px, #{y}px)"

			$target.attr 'data-x', x
			# $target.attr 'data-y', y

			items = document.querySelectorAll(".drag-wrap")
			onScroll()


	# ---------------------------
	# DRAGGABLE BLOCKS
	# ---------------------------
	startPos = null
	interact('.draggable').draggable
		inertia: true
		restrict:
				restriction: 'body'
				endOnly: true
				elementRect:
					top: 0
					left: 0
					bottom: 1
					right: 1
			axis: 'xy'
		# snap:
		# 	targets: [ startPos ]
		# 	relativePoints: [ {
		# 		x: 0.5
		# 		y: 0.5
		# 	} ]
		# 	range: 100
		# 	endOnly: true

		onstart: (event) ->
			rect = interact.getElementRect event.target
			# record center point when starting the very first a drag
			startPos =
				x: rect.left + rect.width / 2
				y: rect.top + rect.height / 2
			# event.interactable.draggable
			# 	snap:
			# 		targets: [ startPos ]
			# 		range: 200

		onmove: (event) ->
			$target = $ event.target
			x = (parseFloat($target.attr 'data-x') or 0) + event.dx
			y = (parseFloat($target.attr 'data-y') or 0) + event.dy

			$target.css
				'-webkit-transform': "translate(#{x}px, #{y}px)"

			# update the posiion attributes
			$target.attr 'data-x', x
			$target.attr 'data-y', y
			$target.addClass 'getting--dragged'

		onend: (event) ->
			$target = $ event.target
			$target.removeClass 'getting--dragged'


	# ---------------------------
	# BUTTONS
	# ---------------------------
	cb = () =>
		console.log "RUN"
	$("#button_run").click =>
		control.run(cb)

	$("#button_reset").click =>
		location.reload()

	window_height = window.innerHeight

	# Logic for the Block Bank
	$(".drag-selector").css
		position: 'absolute'
		top: window_height
		left: 0
		display: 'none'

	# This is to prevent scrolling on the page

	# # ---------------------------
	# # SPEECH RECOGNITION LOGIC
	# # ---------------------------
	# put_text_in_block = (text, block_name) ->
	# 	$("##{block_name}").val(text)

	# commands =
	# 	'put *text in :block_name block': put_text_in_block
	# 	'run': control.run
	# annyang.addCommands commands
	# annyang.start
	# 	continuous: true