(async () => {
	let cls = cls => document.getElementsByClassName(cls)
	let ws = new WeakSet()
	let CDEK = (await import('/vendor/akiyatkin/cdek/CDEK.js')).default
	let CDN = (await import('/vendor/akiyatkin/load/CDN.js')).default
	Event.handler('Controller.onshow', async () => {
		let btns = cls('-cdek-city')
		await CDN.load('jquery')
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
	/*Event.handler('Controller.onshow', async () => {
		
		let CDN = (await import('/vendor/akiyatkin/load/CDN.js')).default
	
		$('-cdek-city').attr('data-cdek','true').click( function() {
			var data = $(this).data();
			if ($(this).data('text')) {
				if (!Session.get('user.text')) {
					Session.set('user.text', $(this).data('text'), false, function(){
						contacts.show(data);
					});
				}
			}
			if ($(this).data('replace')) {
				Session.set('user.text', $(this).data('replace'), false, function(){
					contacts.show(data);
				});
			} else {
				contacts.show(data);	
			}
			
			return false;
		});


		
		let cls = cls => document.getElementsByClassName(cls)
		let list = cls('showCallback')
		for (let i = 0, l = list.length; i < l; i++ ) {
			let el = list[i]
			if (el.showCallback) continue
			el.showCallback = true
			el.addEventListener('click', () => {
				Popup.show(contacts.callback_layer);
			})
		}

	});*/
})()