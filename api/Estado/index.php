<?php

require_once "..\config\database.php";

$db = new Database();

switch ($_SERVER['REQUEST_METHOD']){

    case 'GET':


        if(isset($_GET['id']) && $_GET['id']>0){
            echo json_encode($db->getEstado($_GET['id']));
        }
        
        if(isset($_GET['id']) && $_GET['id']==0){
            echo json_encode($db->getEstadoAll());    
        }
        

        break;
    case 'POST':

        $datos = json_decode(file_get_contents('php://input'));
        $db->InsertEstado($datos->nombre);

        break;
    case 'PUT':

        $datos = json_decode(file_get_contents('php://input'));
        $db->UpdateEstado($datos->estado_id,$datos->nombre);

        break;
    case 'DELETE':
        
        $db->DeleteEstado($_GET['id']);

    default:
    #code...
        break;
}