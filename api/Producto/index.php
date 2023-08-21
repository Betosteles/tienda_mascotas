<?php

require_once "..\config\database.php";


$db = new Database();



switch ($_SERVER['REQUEST_METHOD']){

    case 'GET':

        if(isset($_GET['id']) && $_GET['id']>0){
            echo json_encode($db->getProducto($_GET['id']));
        }
        
        if(isset($_GET['id']) && $_GET['id']==0){
            echo json_encode($db->getProductosAll());    
        }

        if(isset($_GET['name'])){
            echo json_encode($db->getProductoByName($_GET['name']));
 
        }

        if(isset($_GET['idA']) && isset($_GET['idC'])){

            echo json_encode($db->getProductosByAnimalAndCategoria($_GET['idA'],$_GET['idC']));

        }
        

        break;
    case 'POST':

        try{

        $datos = json_decode(file_get_contents('php://input'));
        $db->InsertProductos(
            $datos->categoria_animal_id,
            $datos->categoria_producto_id,
            $datos->nombre,
            $datos->marca,
            $datos->descripcion,
            $datos->precio,
            $datos->stock,
            $datos->codigo_barra,
            $datos->imagenes,
            $datos->garantia);
        }catch(PDOException $e){
            // Manejo del error
            echo $e->getMessage();
          }
        break;
    case 'PUT':
        $datos = json_decode(file_get_contents('php://input'));

        $db->UpdateProductos(
            $datos->producto_id,
            $datos->categoria_animal_id,
            $datos->categoria_producto_id,
            $datos->nombre,
            $datos->marca,
            $datos->descripcion,
            $datos->precio,
            $datos->stock,
            $datos->codigo_barra,
            $datos->imagenes,
            $datos->garantia
        );

        break;
    case 'DELETE':

        $db->DeleteProducto($_GET['id']);

        break;

    default:
    #code...
        break;
}