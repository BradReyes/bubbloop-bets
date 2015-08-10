class @block_time_

	constructor: ()->
		css = """
		.arrowUp {
			position: absolute;
			width: 10px;
			top: 10px;
			left: 10px;
			font-size: 110%;
		}

		.arrowDown {
			position: absolute;
			width: 10px;
			top: 80px;
			left: 10px;
			font-size: 110%;
		}

		div[name='time'] {
			position: relative;
			font-family: 'Orbitron', sans-serif;
			font-size: 120%;
			color: green;
		}

		#hoursBlock {
			position: relative;
			left: 7px;
			top: 17px;
		}

		#minutesBlock {
			position: relative;
			left: 45px;
			top: 17px;
		}

		#timeBlock {
			position: relative;
			left: 90px;
			top: 17px;
		}

		#hours, #minutes, #colon, #time {
			position: absolute;
			top: 5px;
		}

		#hours {
			left: 4px;
		}

		#colon {
			font-weight: bold;
			left: 50px;
			top: 22px;
		}

		#minutes {
			left: 10px;
		}

		#time {
			position: absolute;
			left: 5px;
		}
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class='drag-wrap draggable When' name='time'>
			<div id="hoursBlock">
				<div id="hours">12</div>
				<i class="arrowUp fa fa-arrow-up"></i>
				<i class="arrowDown fa fa-arrow-down"></i>
			</div>
			<div id="colon">:</div>
			<div id="minutesBlock">
				<div id="minutes">00</div>
				<i class="arrowUp fa fa-arrow-up"></i>
				<i class="arrowDown fa fa-arrow-down"></i>
			</div>
			<div id="timeBlock">
				<div id="time">AM</div>
				<i class="arrowUp fa fa-arrow-up"></i>
				<i class="arrowDown fa fa-arrow-down"></i>
			</div>
		</div>
		""").appendTo ".drag-zone"

		#clock logic
		$hours = $ "#hours"
		$minutes = $ "#minutes"
		$time = $ "#time"

		hours_counter = 12
		minutes_counter = 0
		morning = true

		interact('.arrowUp')
		.on 'tap', (event) ->
			block = $(event.currentTarget).parent()[0].id.toString()
			switch block
				when "hoursBlock"
					hours_counter++
					hours_counter = 1 if hours_counter > 12
					hours_text = hours_counter.toString()
					hours_text = "0#{hours_counter}" if hours_counter <= 9
					$hours.text hours_text
				when "minutesBlock"
					minutes_counter++
					minutes_counter = 0 if minutes_counter > 59
					minutes_text = minutes_counter.toString()
					minutes_text = "0#{minutes_counter}" if minutes_counter <= 9
					$minutes.text minutes_text
				when "timeBlock"
					if morning
						$time.text "PM"
						morning = false
					else
						$time.text "AM"
						morning = true
				else console.log "Error. File: block_clock.coffee Function: interact(.arrowUp)"

		interact('.arrowDown')
		.on 'tap', (event) ->
			block = $(event.currentTarget).parent()[0].id.toString()
			switch block
				when "hoursBlock"
					hours_counter--
					hours_counter = 12 if hours_counter <= 0
					hours_text = hours_counter.toString()
					hours_text = "0#{hours_counter}" if hours_counter <= 9
					$hours.text hours_text
				when "minutesBlock"
					minutes_counter--
					minutes_counter = 59 if minutes_counter < 0
					minutes_text = minutes_counter.toString()
					minutes_text = "0#{minutes_counter}" if minutes_counter <= 9
					$minutes.text minutes_text
				when "timeBlock"
					if morning
						$time.text "PM"
						morning = false
					else
						$time.text "AM"
						morning = true
				else console.log "Error. File: block_clock.coffee Function: interact(.arrowUp)"

	get_type: () =>
		"start"

	run: (cb)=>
		@check_time cb
		@interval_id = setInterval @check_time, 7000, cb
		

	check_time: (cb) =>
		clock_hours = $("#hours").text()
		clock_minutes = $("#minutes").text()
		clock_time = $("#time").text()
		console.log clock_hours
		console.log clock_time

		if clock_hours is "12" and clock_time is "AM"
			clock_hours = 0
		else if clock_hours is "12" and clock_time is "PM"
			clock_hours = 12
		else if clock_time is "PM"
			clock_hours = parseInt(clock_hours) + 12


		time_clock = "#{clock_hours}:#{clock_minutes}"
		time_now = moment().format 'HH:mm'
		console.log "Checked time"
		console.log time_now
		console.log time_clock

		if time_now == time_clock
			clearInterval @interval_id
			cb()