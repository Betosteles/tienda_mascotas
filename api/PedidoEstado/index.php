<?php

require_once "..\config\database.php";

$db = new Database();

switch ($_SERVER['REQUEST_METHOD']){

    case 'GET':


        if(isset($_GET['id']) && $_GET['id']>0){
            echo json_encode($db->getPedidoEstado($_GET['id']));
        }
        
        if(isset($_GET['id']) && $_GET['id']==0){
            echo json_encode($db->getPedidoEstadoAll());    
        }

        break;
    case 'POST':

        $datos = json_decode(file_get_contents('php://input'));

        $db->InsertPedidoEstado($datos->pedido_id,$datos->estado_id);

        break;
    case 'PUT':

        $datos = json_decode(file_get_contents('php://input'));
        $db->UpdatePedidoEstado($datos->pedido_id,$datos->estado_id);

        break;
    case 'DELETE':
    
        $db->DeletePedidoEstado($_GET['id']);
    
        break;

    default:
    #code...
        break;
}