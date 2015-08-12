class @block_pizza_

	constructor: ()->
		css = """
			.pizza {
				background-image: url(img/pizza.jpeg);
				background-size: cover;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div class="drag-wrap draggable action Why pizza general_action" name="pizza">
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		console.log "Ordered a pizza"
		alert "Ordered a pizza!"
		# window.open "http://order.dominos.com/en/pages/order/#/locations/search/"