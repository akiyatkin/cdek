import { Fire } from '../load/Fire.js'
import { CDN } from '/vendor/akiyatkin/load/CDN.js'
import { Load } from '/vendor/infrajs/load/Load.js'

export let CDEK = {
	...Fire,
	calc: async (type = "courier") => {
		//type: courier, pickup
		let get = {
			isdek_action: "calc",
			timestamp:Date.now(),
			shipment: {
				cityFromId: Config.get('cdek').cityFromId, //Москва
				cityToId: Session.get('orders.my.cdek.wat.city', Config.get('cdek').defaultCityId),
				"type":type,
				"goods":await CDEK.getGoods()
			}
		}
		let json = await fetch('/-cdek/service.php?' + Load.param(get)).then(async res => await res.json())
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
			await CDN.on('load','cdek.widget')
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
					await CDN.on('load','jquery')
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
	getDim: item => {
		//$item['Габариты']//WxHxL

		let dim = item['Упаковка, см'] ? item['Упаковка, см']: '';
		let weight = item['Вес, кг'] ? item['Вес, кг']: '0.4';

		let d = dim.split(/[хx]/i)
		
		if (!d[0]) d[0] = 6;
		if (!d[1]) d[1] = 15;
		if (!d[2]) d[2] = 12;
		weight = Number(weight);

		return { 
			"width": d[0], 
			"height": d[1], 
			"length": d[2], 
			"weight": weight
		}
	},
	getGoods: async () => {
		let gorder = window.Cart.getGoodOrder()
		let goods = []
		for (let i in gorder.basket) {
			let item = gorder.basket[i]
			let dim = CDEK.getDim(item)
			for (let i = 0; i < item['count']; i++) {
				goods.push(dim)
			}
		}
		console.log(goods)
		return goods
	}
}
window.CDEK = CDEK
export default CDEK