{::}vendor/infrajs/cart/cart.tpl
{transcardsimple:}
	{order.cdek:cdekinfo}
{citychoice:}
	<p>Город: <b class="{(:isdisabled)??:a} {:isdisabled} -cdek-city">{cityName}</b></p>
{cityfix:}
	<p>Город: <b>{cityName}</b></p>
{cdekinfo:}
	{data.order.id?:cityfix?:citychoice}
	
	{pickup?wat.PVZ:pvz}
	{courier?:cur}
	{cur:}
		<p>Стоимость доставки курьером: <b>{~cost(calc.result.price)}{:model.unit}</b></p>
		<div class="row">
			<div class="col-12">
				<div class="form-group">
					<label>Адрес для доставки</label>
					<input {:isdisabled} type="text" name="transport.address" value="{data.order.transport.address}" class="form-control" placeholder="">
				</div>
			</div>
		</div>
	{pvz:}
		<p>Выбран пункт самовывоза <b>{Name}</b> (<b>{..id}</b>)</p>
		<table class="table table-sm">
			<tr><td>Адрес</td><td>{Address}</td></tr>
			<tr><td>Время работы</td><td>{WorkTime}</td></tr>
			<tr><td>Комментарий</td><td>{Note}</td></tr>
		</table>
		<p>Стоимость доставки самовывозом: <b>{~cost(...calc.result.price)}{:model.unit}</b></p>
{iprinttr:}
	<b>Доставка</b>: {..cdek.cityTo}, {..cdek.pickup?:Cамовывоз?:Курьер}, {..cdek.wat.PVZ?..cdek.wat.id?address} (<b>{..cdek.calc.result.price}{:model.unit}</b>)
{amount:}
	Стоимость{sum!total?:nodiscount}: <b>{~cost(sum)}&nbsp;руб.</b><br>
	{sum!total?:prcoupon}
	Доставка: <b>{~cost(cdek.calc.result.price)}&nbsp;руб.</b><br>
{info:}
	<div class="alert alert-secondary">
		{:amount}
	</div>