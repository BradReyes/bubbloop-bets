class @block_pizza_

	constructor: ()->
		css = """
			#pizza {
				background-image: url(img/pizza.jpeg);
				background-size: cover;
			}
		"""
		$("<style type='text/css'></style>").html(css).appendTo "head"

		$("""
		<div id="pizza" class="drag-wrap draggable action" name="pizza">
		</div>
		""").appendTo ".drag-zone"

	run: ()=>
		window.open "http://order.dominos.com/en/pages/order/#/locations/search/"