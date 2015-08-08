class @block_time_end_

	constructor: ()->
		css = """
		.arrowUpEnd {
			position: absolute;
			width: 10px;
			top: 10px;
			left: 10px;
			font-size: 110%;
		}

		.arrowDownEnd {
			position: absolute;
			width: 10px;
			top: 80px;
			left: 10px;
			font-size: 110%;
		}

		div[name='time_end'] {
			position: relative;
			font-family: 'Orbitron', sans-serif;
			font-size: 120%;
			color: red;
		}

		#hoursBlockEnd {
			position: relative;
			left: 7px;
			top: 17px;
		}

		#minutesBlockEnd {
			position: relative;
			left: 45px;
			top: 17px;
		}

		#timeBlockEnd {
			position: relative;
			left: 90px;
			top: 17px;
		}

		#hoursEnd, #minutesEnd, #colonEnd, #timeEnd {
			position: absolute;
			top: 5px;
		}

		#hoursEnd {
			left: 4px;
		}

		#colonEnd {
			font-weight: bold;
			left: 50px;
			top: 22px;
		}

		#minutesEnd {
			left: 10px;
		}

		#timeEnd {
			position: absolute;
			left: 5px;
		}
		"""

		$('<style type="text/css"></style>').html(css).appendTo "head"

		$("""
		<div class='drag-wrap draggable When' name='time_end'>
			<div id="hoursBlockEnd">
				<div id="hoursEnd">12</div>
				<i class="arrowUpEnd fa fa-arrow-up"></i>
				<i class="arrowDownEnd fa fa-arrow-down"></i>
			</div>
			<div id="colonEnd">:</div>
			<div id="minutesBlockEnd">
				<div id="minutesEnd">00</div>
				<i class="arrowUpEnd fa fa-arrow-up"></i>
				<i class="arrowDownEnd fa fa-arrow-down"></i>
			</div>
			<div id="timeBlockEnd">
				<div id="timeEnd">AM</div>
				<i class="arrowUpEnd fa fa-arrow-up"></i>
				<i class="arrowDownEnd fa fa-arrow-down"></i>
			</div>
		</div>
		""").appendTo ".drag-zone"

		#clock logic
		$hours = $ "#hoursEnd"
		$minutes = $ "#minutesEnd"
		$time = $ "#timeEnd"

		hours_counter = 12
		minutes_counter = 0
		morning = true

		interact('.arrowUpEnd')
		.on 'tap', (event) ->
			block = $(event.currentTarget).parent()[0].id.toString()
			switch block
				when "hoursBlockEnd"
					hours_counter++
					hours_counter = 1 if hours_counter > 12
					hours_text = hours_counter.toString()
					hours_text = "0#{hours_counter}" if hours_counter <= 9
					$hours.text hours_text
				when "minutesBlockEnd"
					minutes_counter++
					minutes_counter = 0 if minutes_counter > 59
					minutes_text = minutes_counter.toString()
					minutes_text = "0#{minutes_counter}" if minutes_counter <= 9
					$minutes.text minutes_text
				when "timeBlockEnd"
					if morning
						$time.text "PM"
						morning = false
					else
						$time.text "AM"
						morning = true
				else console.log "Error. File: block_clock.coffee Function: interact(.arrowUp)"

		interact('.arrowDownEnd')
		.on 'tap', (event) ->
			block = $(event.currentTarget).parent()[0].id.toString()
			switch block
				when "hoursBlockEnd"
					hours_counter--
					hours_counter = 12 if hours_counter <= 0
					hours_text = hours_counter.toString()
					hours_text = "0#{hours_counter}" if hours_counter <= 9
					$hours.text hours_text
				when "minutesBlockEnd"
					minutes_counter--
					minutes_counter = 59 if minutes_counter < 0
					minutes_text = minutes_counter.toString()
					minutes_text = "0#{minutes_counter}" if minutes_counter <= 9
					$minutes.text minutes_text
				when "timeBlockEnd"
					if morning
						$time.text "PM"
						morning = false
					else
						$time.text "AM"
						morning = true
				else console.log "Error. File: block_clock.coffee Function: interact(.arrowUp)"

	get_type: () =>
		"end"

	run: ()=>
		@interval_id = setInterval @check_time, 8000

	check_time: () =>
		clock_hours = $("#hoursEnd").text()
		clock_minutes = $("#minutesEnd").text()
		clock_time = $("#timeEnd").text()
		if clock_time is "PM"
			clock_hours = parseInt(clock_hours) + 12

		time_clock = "#{clock_hours}:#{clock_minutes}"
		time_now = moment().format 'HH:mm'
		if time_now == time_clock
			window.location.reload()