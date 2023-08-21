<?php

require_once "..\config\database.php";


$db = new Database();


switch ($_SERVER['REQUEST_METHOD']){

    case 'GET':

        if($_GET['id']!=0){
            echo json_encode($db->getUsuario($_GET['id']));
        }else{
            echo json_encode($db->getUsuariosAll());
        }
        break;

    case 'POST':

        $datos = json_decode(file_get_contents('php://input'));
        $db->InsertUsuario($datos->nombre,$datos->password,$datos->tipo_usuario_id);

        break;

    case 'PUT':

        $datos = json_decode(file_get_contents('php://input'));
        $db->UpdateUsuario($datos->usuario_id,$datos->nombre,$datos->password,$datos->tipo_usuario_id);

        break;

    case 'DELETE':

        $db->DeleteUsuario($_GET['id']);

        break;

    default:
    #code...
        break;
}