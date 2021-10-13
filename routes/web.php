<?php

use Illuminate\Http\Request;
use Illuminate\Http\Response;

$router->get('/', function () {
    $response = array();
    $response['msg'] = 'API de Boletos Banco Inter (NÃO OFICIAL)';
    return (new Response($response));
});