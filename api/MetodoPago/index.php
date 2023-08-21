<?php

require_once "..\config\database.php";

$db = new Database();

switch ($_SERVER['REQUEST_METHOD']){

    
    case 'GET':

        try{
        if ($_GET['id']!=0){    
            echo json_encode($db->getMetododePago($_GET['id']));    
        }else{
            echo json_encode($db->getMetododePagoALL());
        
        }


        }catch(PDOException $e){
        // Manejo del error
        echo $e->getMessage();
      }
      
        break;

    

    case 'POST':

        $datos = json_decode(file_get_contents('php://input'));

        $db->InsertMetodoPago($datos->nombre);

        break;
    case 'PUT':

        $datos = json_decode(file_get_contents('php://input'));

        $db->UpdateMetodoPago($datos->metodo_pago_id,$datos->nombre);

        break;
    case 'DELETE':

        $db->DeleteMetodoPago($_GET['id']);

        break;

    default:
    #code...
        break;
}