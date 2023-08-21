<?php

require_once "..\config\database.php";

$db = new Database();

switch ($_SERVER['REQUEST_METHOD']){

    case 'GET':


        if(isset($_GET['id']) && $_GET['id']>0){
            echo json_encode($db->getPedidoDetalleByPedidoID($_GET['id']));
        }
        
        if(isset($_GET['id']) && $_GET['id']==0){
            echo json_encode($db->getPedidoDetalleAll());    
        }

        if(isset($_GET['idP'])){
            echo json_encode($db->getPedidoDetalleByProductoId($_GET['idP']));
 
        }
        

        break;
    case 'POST':
        try{
        $datos = json_decode(file_get_contents('php://input'));
        $db->InsertPedidoDetalle($datos->id_pedido,$datos->producto_id,$datos->cantidad_producto);
        
    }catch(PDOException $e){
        // Manejo del error
        echo $e->getMessage();
      }

        break;
    case 'PUT':

        $datos = json_decode(file_get_contents('php://input'));
        $db->UpdatePedidoDetalle($datos->id_pedido,$datos->producto_id,$datos->cantidad_producto);

        break;
    case 'DELETE':
        
        if(isset($_GET['idPedido']) && isset($_GET['idProducto'])){

        $db->DeletePedidoDetalle($_GET['idPedido'],$_GET['idProducto']);
        }
        else {
        $db->DeletePedidoDetalleAll($_GET['idPedido']);
        }
        break;

    default:
    #code...
        break;
}