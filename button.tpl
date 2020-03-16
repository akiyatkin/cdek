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
	<h2>Доставка</h2>
	<span class="a showTransport">Доставка (<b class="-city-str"></b>)</span>
	<div class="showres"></div>
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
			btn.addEventListener('click', async () => (await CDEK.getCartWidjet()).open())

			let show = async (showres, wat) => {
				console.log('12312')
				await CDN.load('magnific-popup')
				console.log('asfd')
				showres.innerHTML = window.Template.parse('-cdek/button.tpl', wat, 'showres')
				$(div).find('a.gallery').magnificPopup({
					type: 'image',
					gallery:{
						enabled:true
					}
				})
			}		
			
			CDEK.handler('calc', (wat) => {
				show(showres, wat)
				Session.set('orders.my.cdek', wat)
			})

			
			show(showres, Session.get('orders.my.cdek'))
			
		})()
	</script>
	{showres:}
		{price?:showrespr}
	{showrespr:}
		Выбран пункт выдачи заказа <b>{id}</b>: <b title="{PVZ.AddressComment}">{PVZ.Address}</b> цена <B>{~cost(price)}&nbsp;руб.</b> срок <b>{term} дн.</b> город <b>{cityName}</b> код города <b>{city}</b>
		<div class="d-flex">{PVZ.Picture::img}</div>
	{img:}
		<a class="gallery" href="{.}"><img class="img-fluid mb-2" src="/-imager/?m=1&amp;h=200&amp;src={.}"></a>