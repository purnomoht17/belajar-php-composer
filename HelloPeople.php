<?php

require_once __DIR__ . '/vendor/autoload.php';

use heru\Data\People;

$people = new People("Heru");

echo $people->sayHello("Ellen") . PHP_EOL;