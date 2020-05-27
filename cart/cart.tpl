{::}vendor/infrajs/cart/cart.tpl
{transcardsimple:}
	<div class="form-check">
		<input {data.order.transport.choice=:strsamo?:checked} {:isdisabled} class="transcardsimple form-check-input" type="radio" name="transport.choice" id="checksamo" value="samo">
		<label class="form-check-label" for="checksamo">
			{~conf.cdek.adresasamovivoza}
			<div><a href="/contacts">Схема проезда</a></div>
		</label>
	</div>
		
	<div class="form-check">
		<input {data.order.transport.choice!:strsamo?:checked} {:isdisabled} class="transcardsimple form-check-input" type="radio" name="transport.choice" id="checkcdek" value="cdek">
		<label class="form-check-label" for="checkcdek">
		{order.cdek:cdekinfo}
	</div>
	<script type="module">
		import { Global } from '/vendor/infrajs/layer-global/Global.js'
		let div = document.getElementById('{div}')
		let cls = cls => div.getElementsByClassName(cls)
		for (let inp of cls('transcardsimple')) {
			inp.addEventListener('change', async () => {
				Global.check('cart')
				//DOM.emit('change')
				//Crumb.go('/catalog/' + inp.dataset.nick + select.value + '=1')
			})
		}
	</script>
{citychoice:}
	Доставка транспортной компанией СДЭК: <b>{cityTo}</b>
{cityfix:}
	<p>Доставка транспортной компанией СДЭК: <b>{cityTo}</b></p>
{cdekinfo:}
	{data.order.id?:cityfix?:citychoice}
	{pickup?wat.PVZ:pvz}
	{courier?:cur}
	{data.order.id??:cdekchange}
	{courier?:printaddr}
	{cdekchange:}<div><span class="-cdek-city a fix">Изменить</span></div>
	{printaddr:}
		<div class="row">
			<div class="col-12">
				<div class="form-group">
					<label>Адрес для доставки</label>
					<input {:isdisabled} type="text" name="transport.address" value="{data.order.transport.address}" class="form-control" placeholder="">
				</div>
			</div>
		</div>
	{cur:}
		<div>Стоимость доставки курьером: <b>{~cost(calc.result.price)}{:model.unit}</b></div>
	{pvz:}
		<div>Выбран пункт самовывоза <b>{Name}</b> (<b>{..id}</b>)</div>
		<table class="table table-sm">
			<tr><td>Адрес</td><td>{Address}</td></tr>
			<tr><td>Время&nbsp;работы</td><td>{WorkTime}</td></tr>
			<tr><td>Комментарий</td><td>{Note}</td></tr>
		</table>
		<div>Стоимость доставки до пункта самовывоза: <b>{~cost(...calc.result.price)}{:model.unit}</b></div>
{iprinttr:}
	{choice=:strsamo?:samovivoz?:cdekvivoz}
	{samovivoz:} 
	<b>Доставка</b>: {~conf.cdek.adresasamovivoza}
	{cdekvivoz:}
	<b>Доставка</b>: {..cdek.cityTo}, {..cdek.pickup?:strpickup?:strcourier}, {..cdek.wat.PVZ?..cdek.wat.id?address} (<b>{..cdek.calc.result.price}{:model.unit}</b>)
	{strcourier:}Курьер
	{strpickup:}Самовывоз
	{strsamo:}samo
{amount:}
	<p>
		Стоимость{sum!total?:nodiscount}: {~cost(sum)}&nbsp;руб.<br>
		{sum!total?:prcoupon}
		{transport.choice=:samo?:transsamo?:transcdek}
		
	</p>
	{transsamo:}
		<!-- Всего: <b>{~cost(alltotal)}&nbsp;руб.</b><br> -->
	{transcdek:}
		Доставка ({cdek.cityTo}): {~cost(cdek.calc.result.price)}&nbsp;руб.<br>
		Всего: <b>{~cost(alltotal)}&nbsp;руб.</b><br>
	{samo:}samo