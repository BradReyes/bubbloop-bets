###
instagram_competition_ class
----------------------------
parameters:
1) username1: string
2) username2: string
3) time: number (in minutes)

Competitor object:
id: userid
image: imageObj
###

class @instagram_competition_

	### Constructor ###
	constructor: (@username1, @username2, @time) ->
		console.log """
			#{@username1}
			#{@username2}
			#{@time}
		"""
		@first_time_through = true
		@run_feeds (competitors) =>
			console.log "FINSIHED THE FUCKING LOADING FEEDS"
			console.log @competitors[0].image.likes.count
			console.log @competitors[1].image.likes.count
			console.log "DONE"
		setInterval @run_feeds, 7000, =>
			console.log "seconbd times a charm"
			console.log @competitors[0].image.likes.count
			console.log @competitors[1].image.likes.count
			console.log "DONE"
	### Public Methods ###


	### Private Methods ###
	###
		Takes in a callback that makes sure 
	###
	run_feeds: (cb) =>
		if not @first_time_through
			@get_media @competitors[0].image.id, cb, true
			@get_media @competitors[1].image.id, cb, false
		else
			@get_closest_user @username1, (id) =>
				@player1_id = id
				@get_closest_user @username2, (id) =>
					@player2_id = id
					@find_feeds @player1_id, @player2_id, cb

	find_feeds: (first_player, second_player, cb) =>
		#still a bug somewhere grrrrr
		console.log first_player
		console.log second_player
		both_done = false
		@competitors = [
			{
				id: first_player
				image: null
			}
			{
				id: second_player
				image: null
			}
		]

		first_feed = new Instafeed
			get: 'user'
			userId: parseInt(first_player)
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			limit: 2
			error: ()->
				alert "instagram error"
			success: (json) =>

				image_1 = json.data[0]
				@competitors[0].image = image_1

				second_feed = new Instafeed
					get: 'user'
					userId: parseInt(second_player)
					accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
					clientId: 'f41df43206564056b252ae8a5cb4019e'
					limit: 2
					error: ()->
						alert "instagram error"
					success: (json) =>
						image_2 = json.data[0]
						@competitors[1].image = image_2
						console.log @competitors
						# console.log image_2
						@first_time_through = false

				second_feed.run()

		first_feed.run()

	get_media:(media_id, cb, player1) =>
		#uses @both_medias_finished = false
		access_token = "2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d"
		get_url = "https://api.instagram.com/v1/media/#{media_id}?access_token=#{access_token}"
		$.ajax
			url: get_url
			dataType: "jsonp"
			success: (data) =>
				if player1
					@competitors[0].image = data.data
				else
					@competitors[1].image = data.data

				if @both_medias_finished
					cb @competitors
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
				matching_id = user_list[0].id
				for user in user_list
					if user.username is username
						matching_id = user.id
						break
				console.log "GOT IN SUCCESSSSSSSS"
				console.log matching_id
				cb matching_id