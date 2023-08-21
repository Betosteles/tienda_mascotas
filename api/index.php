<?php

//require_once "./config/database.php";


//$db = new Database();

//$connection = $db->getconnection();

//query de base de datos
//$sql = "SELECT *FROM categoria_producto -- where usuario_id = :usuario_id ";



//insert

//metodo #1
//$sqlInsert = "INSERT INTO usuario (nombre, correo, telefono)
//Values (:nombre, :correo, :telefono) ";
//$stmt = $connection->prepare($sqlInsert);
//$stmt->bindValue('nombre','Pedro Perez');
//$stmt->bindValue('correo','Pedro@Perez.com');
//$stmt->bindValue('telefono',12312323);
//$stmt->execute();

#metodo #2
// $sqlInsert = "INSERT INTO usuario (nombre, correo, telefono) Values (?, ?, ?) ";

// $stmt = $connection->prepare($sqlInsert);
// $params = [
//     ["Juan Perez", "jperez@unah.hn", 12342353],
//     ["Juan Perez", "jperez@unah.hn", 12342353],
//     ["Juan Perez", "jperez@unah.hn", 12342353],
//     ["Juan Perez", "jperez@unah.hn", 12342353],
//     ["Juan Perez", "jperez@unah.hn", 12342353],
//     ["Juan Perez", "jperez@unah.hn", 12342353],
//     ["Juan Perez", "jperez@unah.hn", 12342353],
// ];
// foreach ($params as $param){
//     $stmt->execute($param);
// }





//sentencias preparadas
//$stmt = $connection->prepare($sql);
//$stmt->bindValue('usuario_id', 24);

//$stmt->execute(); // ejecutamos la sentecia

//hacer un fecth de todos los resultados
//$resultado = $stmt->fetchAll(PDO::FETCH_ASSOC); // crear un arreglo asociativo

//$resultado = $db->getArray($sql);

// $datos = json_decode(file_get_contents('php://input'));
// if($db->InsertUsuario($datos->nombre,$datos->password,$datos->tipo_usuario_id)){
//     http_response_code(200);
// }else{
//     http_response_code(400);
// }

//echo json_encode($db->getUsuario($_GET['usuario_id']));

