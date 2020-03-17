{transport:}
	<style>
		.CDEK-widget__popup-mask {
			z-index: 30;
		}
		#{div} .showres a {
			margin:0 5px;
		}
		#{div} .showres a:first-child {
			margin-left:0;
		}
		#{div} .showres a:last-child {
			margin-right:0;
		}
	</style>
	<div class="alert alert-success">
		<h2>Доставка</h2>
		Ваш город: <b class="-city-str"></b>
		<div>
			<span class="a showTransport">Выбрать пункт выдачи</span>
		</div>
		<div class="showres"></div>
	</div>
	<script async type="module">
		(async () => {
			let Load = (await import('/vendor/akiyatkin/load/Load.js')).default
			let CDEK = await Load.on('import-default', '/vendor/akiyatkin/cdek/CDEK.js')
			let CDN = await Load.on('import-default', '/vendor/akiyatkin/load/CDN.js')
			await CDN.load('jquery')

			let div = document.getElementById('{div}')
			let cls = cls => div.getElementsByClassName(cls)[0]
			let btn = cls('showTransport')
			let showres = cls('showres')
			let choice = cls('-city-str')
			choice.addEventListener('click', async () => {
				City.show()
			})
			btn.addEventListener('click', () => CDEK.open())

			let show = async (showres, wat) => {
				await CDN.load('magnific-popup')
				showres.innerHTML = window.Template.parse('-cdek/layout.tpl', wat, 'showres')
				$(div).find('a.gallery').magnificPopup({
					type: 'image',
					gallery:{
						enabled:true
					}
				})
			}		
			
			CDEK.handler('change', (wat) => {
				show(showres, wat)
				Session.set('orders.my.transport.city', wat.cityName)
				Session.set('cdek', wat)
			})

			
			show(showres, Session.get('cdek'))
			
		})()
	</script>
	{showres:}
		{price?:showrespr}
	{showrespr:}
		Выбран пункт выдачи заказа <b>{id}</b>: <b title="{PVZ.AddressComment}">{PVZ.Address}</b> цена <B>{~cost(price)}&nbsp;руб.</b> срок <b>{term} дн.</b> город <b>{cityName}</b> код города <b>{city}</b>
		<div class="d-flex">{PVZ.Picture::img}</div>
	{img:}
		<a class="gallery" href="{.}"><img class="img-fluid mb-2" src="/-imager/?m=1&amp;h=200&amp;src={.}"></a>