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
	<a href="#" data-crumb="false">Тест</a>
	<span class="a showTransport">Показать точки выдачи (<b class="-city-str"></b>)</span>
	<div class="showres"></div>
	<script async type="module">
		(async () => {
			let Load = (await import('/vendor/akiyatkin/load/Load.js')).default
			let CDN = await Load.on('import-default', '/vendor/akiyatkin/load/CDN.js')
			let initgallery = async () => {
				await CDN.load('magnific-popup')
				let div = document.getElementById('{div}')
				$(div).find('a.gallery').magnificPopup({
					type: 'image',
					gallery:{
						enabled:true
					}
				})
			}
			initgallery()

			let div = document.getElementById('{div}')
			let cls = cls => div.getElementsByClassName(cls)[0]
			let btn = cls('showTransport')
			let showed = 0
			
			//let ipjq
			let print = (wat) => {
				//if (wat.profiles) wat = {...wat.profiles.pickup, ...wat}
				let showres = cls('showres')
				if (!showres) return
				console.log('print', wat)
				showres.innerHTML = Template.parse('-cdek/position.tpl', wat, 'showres')
				initgallery()
			}

			let getCartWidjet = async () => {
				if (!window.cartWidjet) {
					await CDN.load('cdek.widget')
					let option = {
						defaultCity: 'Тольятти', //какой город отображается по умолчанию
						cityFrom: 'Москва', // из какого города будет идти доставка
						hidedress: true,
						hidecash: true,
						hidedelt: false,
						servicepath: '/-cdek/service.php',
						path: 'https://widget.cdek.ru/widget/scripts/',
						//path2: '/-catalog/cdek/widget/scripts/',
						apikey: "{~conf.cdek.apikey}",
						choose:true,
						onReady: async () => {
							await CDN.load('jquery')
							$('.CDEK-widget__popup__close-btn').attr('data-crumb','false').attr('onclick','return false');
						},
						onCalculate2: print,
						onChoose: print,
						goods: [
						   { length: 20, width: 20, height: 20, weight: 2 }
						]
					}
					window.cartWidjet = new ISDEKWidjet ({
						...option,
						popup: true
					});
				}
				
				if (cartWidjet.loadedToAction) {
					return cartWidjet
				} else {
					return new Promise(resolve => {
						let timer = setInterval(() => {
							if (!cartWidjet.loadedToAction)
							clearInterval(timer)
							resolve(cartWidjet)
						}, 300)	
					})
				}
			}
			getCartWidjet()
			btn.addEventListener('click', async () => {
				let cartWidjet = await getCartWidjet()
				cartWidjet.open()
			})

			if (Once.omit('-catalog-transport-cdek')) return
			Event.handler('Session.onsync', async () => { 
				let gorder = Cart.getGoodOrder()
				let count = 0
				for (let i in gorder.basket) {
					let item = gorder.basket[i]
					count += item.count
				}
				let cartWidjet = await getCartWidjet()
				cartWidjet.cargo.reset()
				for (let i = 0; i < count; i++) {
					cartWidjet.cargo.add({ 
						length: 20, 
						width: 20, 
						height: 20, 
						weight: 2 
					})
				}
				console.log('sync',cartWidjet.cargo.get())
			});
			
		})()
	</script>
	{showres:}
		{price?:showrespr}
	{showrespr:}
		Выбран пункт выдачи заказа <b>{id}</b>: <b title="{PVZ.AddressComment}">{PVZ.Address}</b> цена <B>{~cost(price)}&nbsp;руб.</b> срок <b>{term} дн.</b> город <b>{cityName}</b> код города <b>{city}</b>
		<div class="d-flex">{PVZ.Picture::img}</div>
	{img:}
		<a class="gallery" href="{.}"><img class="img-fluid mb-2" src="/-imager/?m=1&amp;h=200&amp;src={.}"></a>