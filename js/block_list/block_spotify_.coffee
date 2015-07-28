class @block_spotify_

	constructor: ()->
		css = """
		[name=spotify] {
			background-image: url(img/spotify.png);
			background-size: cover;
		}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id="spotify" class="drag-wrap draggable source" name="spotify">
		</div>
		""").appendTo ".drag-zone"

	run: (celeb, cb) =>
		artist = celeb.name
		$.ajax
			url: "https://api.spotify.com/v1/search?q=" + artist + "&type=track"
			error: (jqXHR, textStatus, errorThrown)->
				console.log jqXHR
				console.log textStatus
				console.log errorThrown
			success: (json,textStatus, z)=>
				@entries = json.tracks.items
				cb @entries