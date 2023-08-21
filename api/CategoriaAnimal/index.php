<?php

require_once "..\config\database.php";

$db = new Database();

switch ($_SERVER['REQUEST_METHOD']){

    case 'GET':
        if($_GET['id']!=0){
            echo json_encode($db->getCategoriaAnimal($_GET['id']));
        }else{
            echo json_encode($db->getCategoriaAnimalAll());
        }
        break;
    case 'POST':
        $datos = json_decode(file_get_contents('php://input'));

         $db->InsertCategoriaAnimal($datos->animal);

        break;
    case 'PUT':

        $datosPut = json_decode(file_get_contents('php://input'));
        
        echo $datosPut->categoria_animal_id;
        echo $datosPut->animal;
        $db->UpdateCategoriaAnimal($datosPut->categoria_animal_id, $datosPut->animal);

        break;
    case 'DELETE':

        $db->DeleteCategoriaAnimal($_GET['id']);
        
        break;

    default:
    #code...
    
        break;
}
