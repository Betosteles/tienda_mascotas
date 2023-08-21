<?php

require_once "..\config\database.php";

$db = new Database();

switch ($_SERVER['REQUEST_METHOD']){

    case 'GET':
        
        if(isset($_GET['id']) && $_GET['id']==0){
            echo json_encode($db->getClienteAll());
            
        }

        if(isset($_GET['id']) && $_GET['id']>0){
            echo json_encode($db->getClientebyId($_GET['id']));
            
        }

        if(isset($_GET['name']) && $_GET['name']!=NULL){
            echo json_encode($db->getClienteByName($_GET['name']));
            break;
        }

        break;
    case 'POST':
        try{
        $datos = json_decode(file_get_contents('php://input'));
        //$nombre,$identificacion,$tel,$correo,$direccion_envio,$información_dicional
        $db->InsertCliente($datos->nombre,$datos->identificacion,$datos->tel,$datos->correo,$datos->direccion_envio,$datos->información_dicional);
        echo json_encode($db->getClienteAll());
        
        }catch(PDOException $e){
        // Manejo del error
        echo $e->getMessage();
      }
        break;
    case 'PUT':
        $datos = json_decode(file_get_contents('php://input'));
        //$id,$nombre,$identificacion,$tel,$correo,$direccion_envio,$información_dicional
        $db->UpdateCliente(
            $datos->cliente_id,
            $datos->nombre,
            $datos->identificacion,
            $datos->tel,
            $datos->correo,
            $datos->direccion_envio,
            $datos->información_dicional
        );

        

        break;
    case 'DELETE':

        $db->DeleteCliente($_GET['id']);

        break;

    default:
    #code...
        break;
}