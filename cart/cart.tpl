{::}vendor/infrajs/cart/cart.tpl
{transcardsimple:}
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