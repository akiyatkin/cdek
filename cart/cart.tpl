{::}vendor/infrajs/cart/cart.tpl
{transcardsimple:}
	{order.cdek:cdekinfo}
{citychoice:}
	Город: <b>{cityTo}</b>
{cityfix:}
	<p>Город: <b>{cityTo}</b></p>
{cdekinfo:}
	{data.order.id?:cityfix?:citychoice}
	{pickup?wat.PVZ:pvz}
	{courier?:cur}
	{data.order.id??:cdekchange}
	{courier?:printaddr}
	{cdekchange:}<p><b class="-cdek-city a fix">Изменить</b></p>
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
		<div>Стоимость доставки самовывозом: <b>{~cost(...calc.result.price)}{:model.unit}</b></div>
{iprinttr:}
	<b>Доставка</b>: {..cdek.cityTo}, {..cdek.pickup?:strpickup?:strcourier}, {..cdek.wat.PVZ?..cdek.wat.id?address} (<b>{..cdek.calc.result.price}{:model.unit}</b>)
	{strcourier:}Курьер
	{strpickup:}Самовывоз
{amount:}
	Стоимость{sum!total?:nodiscount}: <b>{~cost(sum)}&nbsp;руб.</b><br>
	{sum!total?:prcoupon}
	Доставка: <b>{~cost(cdek.calc.result.price)}&nbsp;руб.</b><br>
{info:}
	<div class="alert alert-secondary">
		{:amount}
	</div>