import { CDN } from '/vendor/akiyatkin/load/CDN.js'
import { CDEK } from '/vendor/akiyatkin/cdek/CDEK.js'
import { Event } from '/vendor/infrajs/event/Event.js'
import { DOM } from '/vendor/akiyatkin/load/DOM.js'

let cls = cls => document.getElementsByClassName(cls)
let ws = new WeakSet()
DOM.done('load', async () => {
	let btns = cls('-cdek-city')
	await CDN.on('load','jquery')
	let city = Session.get('orders.my.cdek.wat.cityName', Config.get('cdek').defaultCity)
	for (let btn of btns) {
		if (ws.has(btn)) continue 
		ws.add(btn)
		if (!btn.classList.contains('fix')) btn.innerHTML = city
		if (btn.classList.contains('disabled')) continue
		btn.addEventListener('click', e => CDEK.open())
	}
})
CDEK.hand('change', wat => {
	console.log(wat)
	if (!wat.cityName) return
	Session.set('orders.my.cdek.wat', wat)
	let btns = cls('-cdek-city')
	for (let btn of btns) {
		if (!btn.classList.contains('fix')) btn.innerHTML = wat.cityName
		btn.innerHTML = wat.cityName
	}
	Session.syncNow()
	Global.check('cart')
})