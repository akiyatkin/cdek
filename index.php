<?php
use akiyatkin\cdek\CDEK;
use infrajs\cart\Cart;

$order = Cart::getGoodOrder();
echo '<pre>';
print_r($order['cdek']); 