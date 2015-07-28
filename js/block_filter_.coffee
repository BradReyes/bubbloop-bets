
class @block_filter_

	constructor: ()->
		css = """
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable filter" name="filter">
			FILTER
		</div>
		""").appendTo ".drag-zone"

	run: (element)=>
		# console.log element
		# likes = element.likes.count
		#tags is an array of strings
		# tags = element.tags
		true
