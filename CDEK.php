<?php
namespace akiyatkin\cdek;
use infrajs\cart\Cart;
use infrajs\load\Load;
use infrajs\sequence\Seq;

class CDEK {
	public static $conf;
	public static function calc($gorder) 
	{
		$id = empty($gorder['id'])? 'my' : $gorder['id'];
		
		$conf = CDEK::$conf;
		//type: courier, pickup
		$get = [
			"isdek_action" => "calc",
			"shipment" => [
				"timestamp" => mktime(),
				"cityFromId" => $conf['cityFromId'], //Москва
				"cityToId" => Seq::get($gorder, 'cdek.wat.city', $conf['defaultCityId']),
				"type" => Seq::get($gorder, 'cdek.wat.PVZ')? "pickup": "courier",
				"goods" => CDEK::getGoods($gorder)
			]
		];
		
		$src = '-cdek/service.php?'.http_build_query($get);
		$json = Load::loadJSON($src);
		$json['get'] = $get;
		return $json;
	}
	public static function getGoods($gorder) 
	{	
		$count = 0;
		if(empty($gorder['basket'])) return [];
		foreach ($gorder['basket'] as $item) {
			$count += $item['count'];
		}
		$goods = [];
		for ($i = 0; $i < $count; $i++) {
			array_push($goods, [ 
				"length" => 12, 
				"width" => 6, 
				"height" => 15, 
				"weight" => 0.4 
			]);
		}
		return $goods;
	}
}