class @block_photos_

	constructor: ()->
		css = """
			#first-input{
				position: absolute;
				top: 30%;
				width: 80%;
				left: 6%;
				text-align: center;
				font-size: 12px;
			}

			#second-input{
				position: absolute;
				top: 60%;
				width: 80%;
				left: 6%;
				text-align: center;
				font-size: 12px;
			}

			input[type='text'],
			input[type='number'],
			textarea {
				font-size: 16px;
			}
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable source" name="photos">
			<input id="first-input" type="text" value="">
			<input id="second-input" type="text" value="">
			<div id='instafeed' style='display:none'></div>
		</div>
		""").appendTo ".drag-zone"

		interact("#first-input")
		.on 'tap', (event) =>
			event.preventDefault()
			$("#first-input").focus()
			@expand("#first-input")

		interact("#second-input")
		.on 'tap', (event) =>
			event.preventDefault()
			$("#second-input").focus()
			@expand("#second-input")

		# interact("[name=hashtag]")
		# .on 'tap', (event) =>
		# 	event.preventDefault()
		# 	$("#hashtag_input#{@counter}").focus()
		# 	@expand()


	blacken_background: () =>
		$blacken = $ "<div id='blacken-input'>"
		$blacken.css
			zIndex: 500
			backgroundColor: 'rgba(0,0,0,0.5)'
			width: '100%'
			height: '100%'
			position: 'absolute'
			left: 0
			top: 0
		$("body").prepend $blacken
		# $("body").bind 'touchstart', =>
		# 	$("#popup-input").blur()
		# 	$("#popup-input").remove()
		# 	$blacken.remove()

	expand: (selector) =>
		@blacken_background()
		# width = window.outerWidth;
		# height = window.outerHeight;
		height = document.documentElement.clientHeight
		width = document.documentElement.clientWidth
		box_width = width / 2
		left = width/2 - box_width/2
		value = $(selector).val()
		$popup_input = $("<input id='popup-input' type='text'>")
		$popup_input.val value
		# $popup_input = $("#popup-input")

		$popup_input.appendTo $("body")

		#sets cursor at end
		str_length= $popup_input.val().length * 2;
		$popup_input.focus()
		$popup_input[0].setSelectionRange(str_length, str_length)

		#now get the position of the original input box
		position = $(selector).offset()

		#need to get the scal at this point
		actual = $(selector)[0].getBoundingClientRect().width
		actual_height = $(selector)[0].getBoundingClientRect().height
		scaled = $(selector)[0].offsetWidth
		scale = actual/scaled

		original_width = $(selector).innerWidth()
		original_height = $(selector).innerHeight()
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
				# $("#popup-input").remove()
				# $("#blacken-input").remove()
			else
				new_value = $("#popup-input").val()
				# console.log new_value
				$(selector).val(new_value)
		#this is what happens when the user clicks away from the input box
		$("#popup-input").blur =>
			$("#blacken-input").remove()
			$("#popup-input").remove()

	get_media:(media_id, cb, player1) =>
		#uses @both_medias_finished = false
		access_token = "2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d"
		get_url = "https://api.instagram.com/v1/media/#{media_id}?access_token=#{access_token}"
		$.ajax
			url: get_url
			dataType: "jsonp"
			success: (data) =>
				console.log data

				if player1
					console.log "Player1"
					@competitors.first_val[1] = data.data
				else
					console.log "Player2"
					@competitors.second_val[1] = data.data
				if @both_medias_finished
					cb (@competitors)
				else @both_medias_finished = true


	get_closest_user: (username, cb) =>
		encoded_username = encodeURIComponent username
		access_token = "2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d"
		get_url = "https://api.instagram.com/v1/users/search?q=#{encoded_username}&access_token=#{access_token}"
		$.ajax
			url: get_url
			dataType: "jsonp"
			success: (data) =>
				user_list = data.data
				console.log "USER LIST HERE"
				console.log user_list
				matching_id = user_list[0].id
				for user in user_list
					if user.username is username
						matching_id = user.id
						break
				cb matching_id

	run: (cb)=>
		#alert "Got in run for block_photos"
		#first and second should be ids
		find_feeds = (first, second) =>
			console.log first
			console.log second
			both_done = false
			@competitors =
				"first_val": [
					first
					null
					]
				"second_val": [
					second
					null
					]

			first_feed = new Instafeed
				get: 'user'
				userId: parseInt(first)
				accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
				clientId: 'f41df43206564056b252ae8a5cb4019e'
				limit: 60
				error: ()->
					alert "instagram error"
				success: (json)=>
					list = json.data
					# loops to concatenate
					for cur in list
						console.log cur
						@competitors.first_val[1] = cur
						break
					if both_done
						console.log @competitors
						cb @competitors
						
					else
						both_done = true

			first_feed.run()

			second_feed = new Instafeed
				get: 'user'
				userId: parseInt(second)
				accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
				clientId: 'f41df43206564056b252ae8a5cb4019e'
				limit: 60
				error: ()->
					alert "instagram error"
				success: (json)=>
					list = json.data
					# loops to concatenate
					for cur in list
						console.log cur
						@competitors.second_val[1] = cur
						break
					if both_done
						console.log @competitors
						cb(@competitors)
					else both_done = true

			second_feed.run()

		#This is where logic starts
		both_users_loaded = false

		first_val = $("#first-input").val()
		second_val = $("#second-input").val()

		if (@player1_id?) and (@player2_id?) and (@competitors?)
			#alert "GO IN HERE in findfeeds before"
			# find_feeds @player1_id, @player2_id
			@both_medias_finished = false
			@get_media @competitors.first_val[1].id, cb, true
			@get_media @competitors.second_val[1].id, cb, false
		else
			@get_closest_user first_val, (id) =>
				@player1_id = id
				if both_users_loaded
					console.log "going into feed"
					find_feeds(@player1_id, @player2_id)
				else both_users_loaded = true

			@get_closest_user second_val, (id) =>
				@player2_id = id
				if both_users_loaded
					find_feeds(@player1_id, @player2_id)
				else
					both_users_loaded = true
					console.log "not last one"
