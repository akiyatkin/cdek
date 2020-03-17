import Fire from '../load/Fire.js'
import Load from '../load/Load.js'


export let CDEK = {
	on: (name, arg) => Fire.on(CDEK, name, arg),
	handler: (name, func) => Fire.handler(CDEK, name, func),
	set: (name, arg, val) => Fire.set(CDEK, name, arg, val),
	
	
	change: async (wat) => {
		if (!wat) return
		delete wat.PVZ.Picture
		delete wat.PVZ.placeMark
		delete wat.PVZ.list_block
		CDEK.on('change', wat)
	},
	open: async () => {
		let cartWidjet = await CDEK.getCartWidjet()
		cartWidjet.open()
	},
	close: async () => {
		let cartWidjet = await CDEK.getCartWidjet()
		cartWidjet.close()
	},
	getCartWidjet: async () => {
		if (!window.cartWidjet) {
			let CDN = await Load.on('import-default', '/vendor/akiyatkin/load/CDN.js')
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
				apikey: Config.get('cdek').apikey,
				choose:true,
				onReady: async () => {
					await CDN.load('jquery')
					$('.CDEK-widget__popup__close-btn').attr('data-crumb','false').attr('onclick','return false');
				},
				onCalculate2: CDEK.change,
				onChoose: CDEK.change,
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
}
window.Event.handler('Session.onsync', async () => { 
	let gorder = window.Cart.getGoodOrder()
	let count = 0
	for (let i in gorder.basket) {
		let item = gorder.basket[i]
		count += item.count
	}
	let cartWidjet = await CDEK.getCartWidjet()
	cartWidjet.cargo.reset()
	for (let i = 0; i < count; i++) {
		cartWidjet.cargo.add({ 
			length: 20, 
			width: 10, 
			height: 10, 
			weight: 1 
		})
	}
	console.log('sync',cartWidjet.cargo.get())
});

export default CDEK