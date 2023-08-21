<?php

require_once "..\config\database.php";

$db = new Database();

switch ($_SERVER['REQUEST_METHOD']){

    case 'GET':

        if ($_GET['id']!=0){
            echo json_encode($db->getTipoUsuario($_GET['id']));
        } else {
            echo json_encode($db->getTipoUsuarioAll());
        }

        break;
    case 'POST':

        $datos = json_decode(file_get_contents('php://input'));

        $db->InsertTipoUsuario($datos->nombre);

        break;
    case 'PUT':

        $datos = json_decode(file_get_contents('php://input'));
        $db->UpdateTipoUsuario($datos->tipo_usuario_id,$datos->nombre);

        break;
    case 'DELETE':

        $db->DeleteTipoUsuario($_GET['id']);

        break;

    default:
    #code...
        break;
}