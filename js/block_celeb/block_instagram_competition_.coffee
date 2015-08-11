class @block_instagram_competition_
	constructor: ()->
		css = """
		"""
		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable celeb What" name="instagram_competition">
			<img style='width:100%;height:auto;position:absolute;top:16%;left:0%;' src='http://d13zeczpqm2715.cloudfront.net/wp-content/uploads/2015/06/instagram-logo-vector-image.png'>
		</div>
		""").appendTo ".drag-zone"

	get_type: () =>
		"action"

	run: (who, where, action, helpers)=>
		# ignore the where in this case
		# helpers is an array with block and their own run function
		# passes back true or false for this case
		if ($.inArray("me", who) isnt -1)
			alert "We don't have your instagram account"
			return
		
		# gets all posts from the who array
		@combined_posts = []
		async.forEachOfSeries who, (element, i, cb) =>
			cur_id = element.instagram_id
			@get_images (list) =>
				for item in list
					if @check_filters helpers, item
						@combined_posts.push item
				cb()
			, cur_id
			
		, (err) =>
			action @combined_posts

	check_filters: (helpers, item) =>
		if helpers.length is 0
			return true
		for helper in helpers
			return true if helper.run(item) is true
		return false


	get_images: (cb, user_id) =>
		# get the feed for instagram
		given_id = user_id
		all_posts = []
		feed = new Instafeed
			get: 'user'
			userId: given_id
			accessToken: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
			clientId: 'f41df43206564056b252ae8a5cb4019e'
			limit: 60
			error: ()->
				alert "instagram error"
			success: (json)=>
				list = json.data
				for cur in list
					all_posts.push cur
				cb all_posts

		feed.run()