<?php

use Illuminate\Http\Request;
use Illuminate\Http\Response;

$router->post('/boletos', function (Request $request) {
    $this->validate($request, [
        'name' => 'required'
    ]);

    $response = array();
    $response['msg'] = 'inclusão de boletos';
    return (new Response($response));
});

$router->get('/boletos', function () {
    $response = array();
    $response['msg'] = 'listar boletos';
    return (new Response($response));
});

$router->get('/boletos/{nossoNumero}', function ($nossoNumero) {
    $response = array();
    $response['msg'] = 'detalhar um boleto';
    return (new Response($response));
});

$router->post('/boletos/{nossoNumero}/baixas', function ($nossoNumero) {
    $response = array();
    $response['msg'] = 'dar baixa num boleto';
    return (new Response($response));
});

$router->get('/boletos/{nossoNumero}/pdf', function ($nossoNumero) {
    $response = array();
    $response['msg'] = 'baixar pdf do boleto';
    return (new Response($response));
});
