<?php
namespace akiatkin\cdek;
use infrajs\session\Session;
use infrajs\load\Load;

class CDEK {
	public static $conf = [],
	public static function calc($type = "courier") 
	{
		//type: courier, pickup
		$get = [
			"isdek_action" => "calc",
			"timestamp" => mktime(),
			"shipment" => [
				"cityFromId" => $conf['cityFromId'], //Москва
				"cityToId" => Session::get('orders.my.cdek.city', $conf['defaultCityId']),
				"type" => $type,
				"goods" => CDEK::getGoods()
			]
		];
		
		$json = Load::loadJSON('/-cdek/service.php?'.http_build_query($get);
		/*
			price: "780"
			deliveryPeriodMin: 2
			deliveryPeriodMax: 3
		*/
		return $json;
	},
	public static function getGoods($type = "courier") 
	{
		return [];
	}
}