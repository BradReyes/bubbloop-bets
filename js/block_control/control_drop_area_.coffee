class @control_drop_area_

	constructor: ()->
		css = """
			.drop_area {
				position: relative;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id='current-step' class='text'></div>
		<div class='drop_area' role='drop_area'></div>
		""").appendTo $("body")
		@celebrity = new control_drag_zone_ 5, 50, 365, 'celeb'


	expand: (block_name) ->
		current_counter = window.counter
		switch current_counter
			when 1 #this is after celeb has been dragged in
				#will expand to drop zone in celeb
				@location = new control_drag_zone_ 45, 75, 205, 'source'
				# @source.run(@celebrity)
			when 2
				#expand to overlap once
				@destination = new control_drag_zone_ 125, 75, 205, 'filter'
			when 3
				#expand to triple circles
				@action = new control_drag_zone_ 85, 182, 205, 'action'
			when 4
				#run button shows up!
				@create_button()

	create_button: () ->
		$blacken = $("<div id='blackened-background-button'></div>").css
			'z-index':'500'
			'opacity': '0.5'
			'background-color': 'black'
			width: '100%'
			height: '100%'
			position: 'absolute'
			left: '0px'
			top: '0px'

		$("body").prepend $blacken

		$new_div = $("""
			<div id="new-button">
				<p style='position:absolute;font-size: 25px;left:17px;top:5px;' >RUN!</p>
			</div>
		""")

		$new_div.css
			borderRadius: 100
			width: 90
			height: 90
			position: 'absolute'
			top: 180
			left: 140
			zIndex: 1000
			backgroundColor: 'white'
		$("body").prepend $new_div
		$new_div.addClass 'can--drop'
		$new_div.bind 'tap click',()=>
			@run()

	begin_animation: () =>
		$("#new-button").remove()
		$("#blackened-background-button").remove()
		$(".drop-zone").remove()
		$("<div id='white-background-geocaching'></div>").prependTo $("body")
		$("#white-background-geocaching").css
			width: '100%'
			height: '100%'
			# 'background-color': 'white'
			'z-index': '1500'
			'background-image': 'url("img/earth.gif")'
			'background-size': '70% auto'
			'background-repeat': 'no-repeat'
			'background-position': 'center 30%'
		$("<h4 id='geocaching-message-coordinate'>##</h4>").prependTo $("body")
		$("</br><h1 id='geocaching-message'>Your Coordinates</h1>").prependTo $("body")
		$("#geocaching-message").css
			'text-align': 'center'
			'color': 'white'
		$("#geocaching-message-coordinate").css
			'text-align': 'center'
			'color':'white'

	run: ()->
		@begin_animation()
		geocaching = ()=>
			@location.run (latLng) =>
				cur_lat = latLng.lat()
				cur_lng = latLng.lng()
				$("#geocaching-message-coordinate").text "#{cur_lat}, #{cur_lng}"
				@destination.run latLng, (is_true)=>
					@action() if is_true
		geocaching()
		setInterval geocaching, 7000