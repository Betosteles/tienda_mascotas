<?php
// Verificamos si se recibió el archivo
try{
if(isset($_FILES['imagen'])) {
    // Obtenemos los datos del archivo
    $nombreArchivo = $_FILES['imagen']['name'];
    $tipoArchivo = $_FILES['imagen']['type'];
    $tamanoArchivo = $_FILES['imagen']['size'];
    $tempArchivo = $_FILES['imagen']['tmp_name'];
    
    // Obtenemos la extensión del archivo
    $extension = pathinfo($nombreArchivo, PATHINFO_EXTENSION);
    
    // Generamos un nuevo nombre para el archivo
    $nuevoNombre = $_POST['animal'] . '-' . $_POST['categoria'] . '-' . $_POST['nombre'] . '-' . $_POST['marca'] . '.' . $extension;
    
    // Movemos el archivo a la carpeta de destino
    if(move_uploaded_file($tempArchivo, '' . $nuevoNombre)) {
        echo 'Imagen guardada correctamente';
    } else {
        echo 'Error al guardar la imagen';
    }
} else {
    echo 'No se recibió ningún archivo';
}
}catch(PDOException $e){
    // Manejo del error
    echo $e->getMessage();
  }
?>
