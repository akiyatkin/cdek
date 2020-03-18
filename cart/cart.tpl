{::}vendor/infrajs/cart/cart.tpl
{transcardsimple:}
	{order.cdek:cdekinfo}
{noinfo:}
	<p><b class="a -cdek-city fix">Выберите способ доставки</b> <span class="req">*</span></p>

{cdekinfo:}
	<p>Город: <b class="a -cdek-city"></b></p>
	{pickup?wat.PVZ:pvz}
	{courier?:cur}
	{cur:}
		<p>Стоимость доставки курьером: <b>{~cost(price)}{:model.unit}</b></p>
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
		<p>Стоимость доставки самовывозом: <b>{~cost(...price)}{:model.unit}</b></p>
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