{::}vendor/infrajs/cart/cart.tpl
{transcardsimple:}
	
	{order.cdek??:noinfo}
	{order.cdek:cdekinfo}
{noinfo:}
	<p><b class="a -cdek-city fix">Выберите способ доставки</b> <span class="req">*</span></p>

{cdekinfo:}
	<p>Город: <b class="a -cdek-city"></b></p>
	{PVZ?PVZ:pvz}
	{price?:cdekcost}
	{cdekcost:}Стоимость доставки: <b>{~cost(price)} {:model.unit}</b>
	{pvz:}
		<p>Выбран пункт самовывоза <b>{Name}</b> (<b>{..id}</b>)</p>
		<table class="table table-sm">
			<tr><td>Адрес</td><td>{Address}</td></tr>
			<tr><td>Время работы</td><td>{WorkTime}</td></tr>
			<tr><td>Комментарий</td><td>{Note}</td></tr>
		</table>
{*:}
	<div class="row">
		<div class="col-12">
			<div class="form-group">
				<label>Адрес для доставки или адрес пункта выдачи</label>
				<input {:isdisabled} type="text" name="transport.address" value="{data.order.transport.address}" class="form-control" placeholder="">
			</div>
		</div>
		<div class="col-12">
			<div class="form-group">
				<label>Серия и номер паспорта для транспортной компании</label>
				<input {:isdisabled} type="text" name="transport.passeriya"  value="{data.order.transport.passeriya}" class="form-control">
			</div>
		</div>
	</div>