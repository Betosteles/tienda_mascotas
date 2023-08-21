<?php

require_once "..\config\database.php";

$db = new Database();

switch ($_SERVER['REQUEST_METHOD']){

    case 'GET':
        if($_GET['id']!=0){
            echo json_encode($db->getCategoriaProducto($_GET['id']));
        }else{
            echo json_encode($db->getCategoriaProductoAll());
        }
        break;
    case 'POST':
        $datos = json_decode(file_get_contents('php://input'));

        $db->InsertCategoriaProducto($datos->nombre);

        break;
    case 'PUT':
        $datos = json_decode(file_get_contents('php://input'));

         $db->UpdateCategoriaAnimal($datos->categoria_producto_id,$datos->nombre);

        break;
    case 'DELETE':

        $db->DeleteCategoriaProducto($_GET['id']);

        break;

    default:
    #code...
        break;
}