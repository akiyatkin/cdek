(async () => {
	
	/*Event.handler('Controller.onshow', async () => {
		let CDEK = (await import('/vendor/akiyatkin/cdek/CDEK.js')).default
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