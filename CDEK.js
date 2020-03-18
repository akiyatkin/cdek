import Fire from '../load/Fire.js'


export let CDEK = {
	on: (name, arg) => Fire.on(CDEK, name, arg),
	handler: (name, func) => Fire.handler(CDEK, name, func),
	set: (name, arg, val) => Fire.set(CDEK, name, arg, val),
	calc: async (type = "courier") => {
		//type: courier, pickup
		let get = {
			isdek_action: "calc",
			timestamp:Date.now(),
			shipment: {
				cityFromId: Config.get('cdek').cityFromId, //Москва
				cityToId: Session.get('orders.my.cdek.city', Config.get('cdek').defaultCityId),
				"type":type,
				"goods":await CDEK.getGoods()
			}
		}
		let CDN = (await import('/vendor/akiyatkin/load/CDN.js')).default
		await CDN.load('jquery')
		let json = await fetch('/-cdek/service.php?' + $.param(get)).then(res => res.json())
		/*
			price: "780"
			deliveryPeriodMin: 2
			deliveryPeriodMax: 3
		*/
		return json
	},
	change: async (wat) => {
		if (!wat) return
		if (wat.PVZ) {
			delete wat.PVZ.Picture
			delete wat.PVZ.placeMark
			delete wat.PVZ.list_block
		}
		CDEK.on('change', wat)
	},
	open: async () => {
		import('/vendor/akiyatkin/hatloader/HatLoader.js').then( (obj) => {
			let HatLoader = obj.default;
			HatLoader.show('Загружается карта...')
		})
		let cartWidjet = await CDEK.getCartWidjet()
		cartWidjet.open()
		import('/vendor/akiyatkin/hatloader/HatLoader.js').then( (obj) => {
			let HatLoader = obj.default;
			HatLoader.hide()
		})
	},
	close: async () => {
		let cartWidjet = await CDEK.getCartWidjet()
		cartWidjet.close()
	},
	getCartWidjet: async () => {
		if (!window.cartWidjet) {
			let CDN = (await import('/vendor/akiyatkin/load/CDN.js')).default
			await CDN.load('cdek.widget')
			let option = {
				//defaultCity: 'Тольятти', //какой город отображается по умолчанию
				cityFrom: Config.get('cdek').cityFrom, // из какого города будет идти доставка
				//country: 'Россия',
				hidedress: true,
				hidecash: true,
				hidedelt: false,
				servicepath: '/-cdek/service.php',
				popup: true,
				path: 'https://widget.cdek.ru/widget/scripts/',
				//path2: '/-catalog/cdek/widget/scripts/',
				apikey: Config.get('cdek').apikey,
				choose:true,
				onReady: async () => {
					await CDN.load('jquery')
					$('.CDEK-widget__popup__close-btn').attr('data-crumb','false').attr('onclick','return false');
				},
				onChooseProfile: CDEK.change,
				onCalculate: CDEK.change,
				onChoose: CDEK.change,
				goods: await CDEK.getGoods()
			}
			window.cartWidjet = new ISDEKWidjet(option);
		}
		if (cartWidjet.loadedToAction) {
			return cartWidjet
		} else {
			return new Promise(resolve => {
				let timer = setInterval(() => {
					if (!cartWidjet.loadedToAction) return
					clearInterval(timer)
					resolve(cartWidjet)
				}, 300)	
			})
		}
	},
	getGoods: async () => {
		let gorder = window.Cart.getGoodOrder()
		let count = 0
		for (let i in gorder.basket) {
			let item = gorder.basket[i]
			count += item.count
		}
		let goods = []
		for (let i = 0; i < count; i++) {
			goods.push({ 
				length: 20, 
				width: 10, 
				height: 10, 
				weight: 1 
			})
		}
		console.log(goods)
		return goods
	}
}
window.CDEK = CDEK
export default CDEK