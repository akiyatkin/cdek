<?php
use akiyatkin\cdek\CDEK;
use infrajs\event\Event;
use infrajs\config\Config;
use infrajs\sequence\Seq;


Event::handler('Order.calc', function (&$gorder) {
	$conf = CDEK::$conf;
	if (empty($order['cdek'])) $order['cdek'] = [];
	//gorder[cdek][wat] не трогаем
	$gorder['cdek']['cityFromId'] = $conf['cityFromId'];
	$gorder['cdek']['cityFrom'] = $conf['cityFrom'];
	$gorder['cdek']['cityToId'] = Seq::get($gorder, 'cdek.wat.city', $conf['defaultCityId']);
	$gorder['cdek']['cityTo'] = Seq::get($gorder, 'cdek.wat.cityName', $conf['defaultCity']);
	$gorder['cdek']['type'] = Seq::get($gorder, 'cdek.wat.PVZ')? "pickup": "courier";
	$gorder['cdek']['calc'] = CDEK::calc($gorder);
	$gorder['cdek'][$gorder['cdek']['type']] = true;
	$gorder['alltotal'] = $gorder['total'] + $gorder['cdek']['calc']['result']['price'];
});

