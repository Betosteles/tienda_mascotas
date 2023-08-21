<?php

class Database {

    //propiedades
    private $host = 'localhost'; // 127.0.0.1
    private $user = 'root';      // no debe ser publciada en repositorios
    private $password = '12345678';  // no debe ser publciada en repositorios
    private $database = 'dbstore';

    private $connection;


    //constructor
    public function __construct(){

       try{
           $this->connection = new PDO("mysql:host={$this->host};dbname={$this->database}",
               $this->user, $this->password );
           $this->connection->setAttribute(
               PDO::ATTR_ERRMODE,
               PDO:: ERRMODE_EXCEPTION);
//           echo "ok";
       }catch (PDOException $e){
           echo "Error: ". $e->getMessage();
       }
    }

    public function getconnection(){
        return $this->connection;
    }

    public function getArray($sql){

        $stmt = $this->connection->prepare($sql);
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

//******************************************************************************************************************************************************
// _______  _______  _______  _______ _________ _______  _          ______   _______    _______  _______  _        _______  _______ _________ _______ 
// (  ____ \(  ____ \(  ____ \(  ____ \\__   __/(  ___  )( (    /|  (  __  \ (  ____ \  (  ____ \(  ____ \( \      (  ____ \(  ____ \\__   __/(  ____ \
// | (    \/| (    \/| (    \/| (    \/   ) (   | (   ) ||  \  ( |  | (  \  )| (    \/  | (    \/| (    \/| (      | (    \/| (    \/   ) (   | (    \/
// | (_____ | (__    | |      | |         | |   | |   | ||   \ | |  | |   ) || (__      | (_____ | (__    | |      | (__    | |         | |   | (_____ 
// (_____  )|  __)   | |      | |         | |   | |   | || (\ \) |  | |   | ||  __)     (_____  )|  __)   | |      |  __)   | |         | |   (_____  )
//       ) || (      | |      | |         | |   | |   | || | \   |  | |   ) || (              ) || (      | |      | (      | |         | |         ) |
// /\____) || (____/\| (____/\| (____/\___) (___| (___) || )  \  |  | (__/  )| (____/\  /\____) || (____/\| (____/\| (____/\| (____/\   | |   /\____) |
// \_______)(_______/(_______/(_______/\_______/(_______)|/    )_)  (______/ (_______/  \_______)(_______/(_______/(_______/(_______/   )_(   \_______)
//******************************************************************************************************************************************************

    public function getCategoriaAnimal($id){

        $stmt = $this->connection->prepare("
        SELECT `categoria_animal`.`categoria_animal_id`,
        `categoria_animal`.`animal`
        FROM `dbstore`.`categoria_animal` WHERE categoria_animal_id = $id;
        ");

        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getCategoriaAnimalAll(){

        $stmt = $this->connection->prepare("
        SELECT `categoria_animal`.`categoria_animal_id`,
        `categoria_animal`.`animal`
        FROM `dbstore`.`categoria_animal`;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }


    public function getCategoriaProductoAll(){

        $stmt = $this->connection->prepare("
        SELECT `categoria_producto`.`categoria_producto_id`,
        `categoria_producto`.`nombre`
        FROM `dbstore`.`categoria_producto`;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getCategoriaProducto($id){

        $stmt = $this->connection->prepare("
        SELECT `categoria_producto`.`categoria_producto_id`,
        `categoria_producto`.`nombre`
        FROM `dbstore`.`categoria_producto`
        WHERE categoria_producto_id = $id;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getClienteById($id){

        $stmt = $this->connection->prepare("
        SELECT `cliente`.`cliente_id`,
        `cliente`.`nombre`,
        `cliente`.`identificacion`,
        `cliente`.`tel`,
        `cliente`.`correo`,
        `cliente`.`direccion_envio`,
        `cliente`.`informacion_dicional`
        FROM `dbstore`.`cliente` where cliente_id = $id;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getClienteAll(){

        $stmt = $this->connection->prepare("
        SELECT `cliente`.`cliente_id`,
        `cliente`.`nombre`,
        `cliente`.`identificacion`,
        `cliente`.`tel`,
        `cliente`.`correo`,
        `cliente`.`direccion_envio`,
        `cliente`.`informacion_dicional`
        FROM `dbstore`.`cliente`;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getClienteByName($Name){

        $stmt = $this->connection->prepare("
        SELECT `cliente`.`cliente_id`,
        `cliente`.`nombre`,
        `cliente`.`identificacion`,
        `cliente`.`tel`,
        `cliente`.`correo`,
        `cliente`.`direccion_envio`,
        `cliente`.`informacion_dicional`
        FROM `dbstore`.`cliente` where nombre = '$Name';
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getMetododePagoALL(){

        $stmt = $this->connection->prepare("
        SELECT *  FROM `dbstore`.`metodo_pago`;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getMetododePago($id){

        $stmt = $this->connection->prepare("
        SELECT `metodo_pago`.`metodo_pago_id`,
        `metodo_pago`.`nombre`
        FROM `dbstore`.`metodo_pago`
        WHERE metodo_pago_id = $id;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getPedidoAll(){

        $stmt = $this->connection->prepare("
        SELECT `pedido`.`id_pedido`,
        `pedido`.`fecha_pedido`,
        `pedido`.`cliente_id`,
        `pedido`.`metodo_pago_id`
         FROM `dbstore`.`pedido`;    

        ");

    
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getPedidoByCliente($cliente_id){

        $stmt = $this->connection->prepare("
        SELECT `pedido`.`id_pedido`,
        `pedido`.`fecha_pedido`,
        `pedido`.`cliente_id`,
        `pedido`.`metodo_pago_id`
         FROM `dbstore`.`pedido`   

         WHERE cliente_id = '$cliente_id';

        ");

    
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getPedido($id){

        $stmt = $this->connection->prepare("
        SELECT `pedido`.`id_pedido`,
        `pedido`.`fecha_pedido`,
        `pedido`.`cliente_id`,
        `pedido`.`metodo_pago_id`
         FROM `dbstore`.`pedido`  
        WHERE id_pedido = $id;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getPedidoDetalleAll(){

        $stmt = $this->connection->prepare("
        SELECT `pedido_detalle`.`id_pedido`,
        `pedido_detalle`.`producto_id`,
        `pedido_detalle`.`cantidad_producto`
        FROM `dbstore`.`pedido_detalle`;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getPedidoAllDesc(){

        $stmt = $this->connection->prepare("
        SELECT *
        FROM `dbstore`.`pedido`
        ORDER by id_pedido DESC;
        ");



        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }


    public function getPedidoAllDescLimitAndOffset($LIMIT , $OFFSET){

        $stmt = $this->connection->prepare("
        SELECT * FROM `dbstore`.`pedido` ORDER BY id_pedido DESC LIMIT $LIMIT OFFSET $OFFSET;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }


    public function getPedidoTotal(){

        $stmt = $this->connection->prepare("
        SELECT COUNT(*) AS total FROM `dbstore`.`pedido`;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }
    

    public function getPedidoDetalleByPedidoID($pedidoId){

        $stmt = $this->connection->prepare("
        SELECT `pedido_detalle`.`id_pedido`,
        `pedido_detalle`.`producto_id`,
        `pedido_detalle`.`cantidad_producto`
        FROM `dbstore`.`pedido_detalle`
        WHERE id_pedido = $pedidoId;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getPedidoDetalleByProductoId($productoId){

        $stmt = $this->connection->prepare("
        SELECT `pedido_detalle`.`id_pedido`,
        `pedido_detalle`.`producto_id`,
        `pedido_detalle`.`cantidad_producto`
        FROM `dbstore`.`pedido_detalle`
        WHERE id_pedido = $productoId;
        ");
        
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }





    public function getProductosAll(){
        try {
        $stmt = $this->connection->prepare("SELECT `producto`.`producto_id`,
        `producto`.`categoria_animal_id`,
        `producto`.`categoria_producto_id`,
        `producto`.`nombre`,
        `producto`.`marca`,
        `producto`.`descripcion`,
        `producto`.`precio`,
        `producto`.`stock`,
        `producto`.`codigo_barra`,
        `producto`.`imagenes`,
        `producto`.`garantia`
        FROM `dbstore`.`producto`;
    ");
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    } catch (PDOException  $th) {
        echo "Mensaje de Error: " . $th->getMessage();
    }
    }

    public function getProductosByAnimalAndCategoria($idAnimal,$idCategoria){
        try {
        $stmt = $this->connection->prepare("SELECT `producto`.`producto_id`,
        `producto`.`categoria_animal_id`,
        `producto`.`categoria_producto_id`,
        `producto`.`nombre`,
        `producto`.`marca`,
        `producto`.`descripcion`,
        `producto`.`precio`,
        `producto`.`stock`,
        `producto`.`codigo_barra`,
        `producto`.`imagenes`,
        `producto`.`garantia`
        FROM `dbstore`.`producto`
        WHERE categoria_animal_id = $idAnimal AND categoria_producto_id = $idCategoria;
    ");
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    } catch (PDOException  $th) {
        echo "Mensaje de Error: " . $th->getMessage();
    }
    }

    public function getProducto($id){

        try {
        
        $stmt = $this->connection->prepare("SELECT `producto`.`producto_id`,
        `producto`.`categoria_animal_id`,
        `producto`.`categoria_producto_id`,
        `producto`.`nombre`,
        `producto`.`marca`,
        `producto`.`descripcion`,
        `producto`.`precio`,
        `producto`.`stock`,
        `producto`.`codigo_barra`,
        `producto`.`imagenes`,
        `producto`.`garantia`
        FROM `dbstore`.`producto`
        WHERE producto_id = $id;
    ");
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    } catch (PDOException  $th) {
        echo "Mensaje de Error: " . $th->getMessage();
    }
    }

    public function getProductoByName($Name){
        try {            
        $stmt = $this->connection->prepare("SELECT `producto`.`producto_id`,
        `producto`.`categoria_animal_id`,
        `producto`.`categoria_producto_id`,
        `producto`.`nombre`,
        `producto`.`marca`,
        `producto`.`descripcion`,
        `producto`.`precio`,
        `producto`.`stock`,
        `producto`.`codigo_barra`,
        `producto`.`imagenes`
        FROM `dbstore`.`producto`
        WHERE nombre LIKE '%$Name%';
    ");
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;

    } catch (PDOException  $th) {
        echo "Mensaje de Error: " . $th->getMessage();
    }
    }

    public function getTipoUsuarioAll(){

        $stmt = $this->connection->prepare("
        SELECT `tipo_usuario`.`tipo_usuario_id`,
        `tipo_usuario`.`nombre`
        FROM `dbstore`.`tipo_usuario`;
    ");
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getTipoUsuario($id){

        $stmt = $this->connection->prepare("
        SELECT `tipo_usuario`.`tipo_usuario_id`,
        `tipo_usuario`.`nombre`
        FROM `dbstore`.`tipo_usuario`
        where tipo_usuario_id = $id;
    ");
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }


    public function getUsuariosAll(){

        $stmt = $this->connection->prepare("
        SELECT `usuario`.`usuario_id`,
        `usuario`.`nombre`,
        `usuario`.`password`,
        `usuario`.`tipo_usuario_id`
        FROM `dbstore`.`usuario`;

    ");
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getUsuario($id){

        $stmt = $this->connection->prepare("
        SELECT `usuario`.`usuario_id`,
        `usuario`.`nombre`,
        `usuario`.`password`,
        `usuario`.`tipo_usuario_id`
        FROM `dbstore`.`usuario`
        where usuario_id = $id;
    ");
        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }
   
//******************************************************************************************************************************************************
//  _______  _______  _______  _______ _________ _______  _          ______   _______   _________ _        _______  _______  _______ _________ _______ 
// (  ____ \(  ____ \(  ____ \(  ____ \\__   __/(  ___  )( (    /|  (  __  \ (  ____ \  \__   __/( (    /|(  ____ \(  ____ \(  ____ )\__   __/(  ____ \
// | (    \/| (    \/| (    \/| (    \/   ) (   | (   ) ||  \  ( |  | (  \  )| (    \/     ) (   |  \  ( || (    \/| (    \/| (    )|   ) (   | (    \/
// | (_____ | (__    | |      | |         | |   | |   | ||   \ | |  | |   ) || (__         | |   |   \ | || (_____ | (__    | (____)|   | |   | (_____ 
// (_____  )|  __)   | |      | |         | |   | |   | || (\ \) |  | |   | ||  __)        | |   | (\ \) |(_____  )|  __)   |     __)   | |   (_____  )
//       ) || (      | |      | |         | |   | |   | || | \   |  | |   ) || (           | |   | | \   |      ) || (      | (\ (      | |         ) |
// /\____) || (____/\| (____/\| (____/\___) (___| (___) || )  \  |  | (__/  )| (____/\  ___) (___| )  \  |/\____) || (____/\| ) \ \__   | |   /\____) |
// \_______)(_______/(_______/(_______/\_______/(_______)|/    )_)  (______/ (_______/  \_______/|/    )_)\_______)(_______/|/   \__/   )_(   \_______)
//******************************************************************************************************************************************************    
    
    public function InsertCategoriaAnimal($animal){

        $stmt = $this->connection->prepare("

        INSERT INTO `dbstore`.`categoria_animal`
        (`animal`)
        VALUES
        (?);

        ");

        $params = [$animal];
        $stmt->execute($params); 
    }


    public function InsertCategoriaProducto($producto){

        $stmt = $this->connection->prepare("

            INSERT INTO `dbstore`.`categoria_producto`
            (`nombre`)
            VALUES
            (?);

        ");

        $params = [$producto];
        $stmt->execute($params); 
    }

    public function InsertMetodoPago($nombre){

        $stmt = $this->connection->prepare("

            INSERT INTO `dbstore`.`metodo_pago`
            (`nombre`)
            VALUES
            (?);
        
        ");

        $params = [$nombre];
        $stmt->execute($params); 
    }




    public function InsertCliente($nombre,$identificacion,$tel,$correo,$direccion_envio,$información_dicional){

        $stmt = $this->connection->prepare("
        
            INSERT INTO `dbstore`.`cliente`
            (`nombre`,
            `identificacion`,
            `tel`,
            `correo`,
            `direccion_envio`,
            `informacion_dicional`)
            VALUES
            (?,?,?,?,?,?);
        
        ");

        $params = [$nombre,$identificacion,$tel,$correo,$direccion_envio,$información_dicional];
        $stmt->execute($params); // ejecutamos la sentecia

    }

    public function InsertPedido($fecha_pedido,$cliente_id,$metodo_pago_id){

        $stmt = $this->connection->prepare("
        INSERT INTO `dbstore`.`pedido`
        (`fecha_pedido`,
        `cliente_id`,
        `metodo_pago_id`)
        VALUES
        (?,?,?)
        
        ");

        $params = [$fecha_pedido,$cliente_id,$metodo_pago_id];
        $stmt->execute($params); 
    }
    

    public function InsertPedidoDetalle($id_pedido,$producto_id,$cantidad_producto){

        $stmt = $this->connection->prepare("
        INSERT INTO `dbstore`.`pedido_detalle`
        (`id_pedido`,
        `producto_id`,
        `cantidad_producto`)
        VALUES
        (?,?,?);

        ");

        $params = [$id_pedido,$producto_id,$cantidad_producto];
        $stmt->execute($params); 
    }



    public function InsertProductos($categoria_animal_id,$categoria_producto_id,$nombre,$marca,$descripcion,$precio,$stock,$codigo_barra,$imagenes,$garantia){

        $stmt = $this->connection->prepare("
        INSERT INTO `dbstore`.`producto`
        (`categoria_animal_id`,
        `categoria_producto_id`,
        `nombre`,
        `marca`,
        `descripcion`,
        `precio`,
        `stock`,
        `codigo_barra`,
        `imagenes`,
        `garantia`)
        VALUES
        (?,?,?,?,?,?,?,?,?,?);

        ");

        $params = [$categoria_animal_id,$categoria_producto_id,$nombre,$marca,$descripcion,$precio,$stock,$codigo_barra,$imagenes,$garantia];
        $stmt->execute($params); // ejecutamos la sentecia

    }



    public function InsertTipoUsuario($nombre){

        $stmt = $this->connection->prepare("
        INSERT INTO `dbstore`.`tipo_usuario`
        (`nombre`)
        VALUES
        (?);
        ");

        $params = [$nombre];
        $stmt->execute($params); 
    }




    public function InsertUsuario($nombre,$password,$tipo_usuario_id){

        $stmt = $this->connection->prepare("
        INSERT INTO `dbstore`.`usuario`
        (`nombre`,
        `password`,
        `tipo_usuario_id`)
        VALUES
        (?,?,?);
        ");

        $params = [$nombre,$password,$tipo_usuario_id];
        $stmt->execute($params); 
    }


   
//******************************************************************************************************************************************************
//  _______  _______  _______  _______ _________ _______  _          ______   _______             _______  ______   _______ _________ _______  _______ 
// (  ____ \(  ____ \(  ____ \(  ____ \\__   __/(  ___  )( (    /|  (  __  \ (  ____ \  |\     /|(  ____ )(  __  \ (  ___  )\__   __/(  ____ \(  ____ \
// | (    \/| (    \/| (    \/| (    \/   ) (   | (   ) ||  \  ( |  | (  \  )| (    \/  | )   ( || (    )|| (  \  )| (   ) |   ) (   | (    \/| (    \/
// | (_____ | (__    | |      | |         | |   | |   | ||   \ | |  | |   ) || (__      | |   | || (____)|| |   ) || (___) |   | |   | (__    | (_____ 
// (_____  )|  __)   | |      | |         | |   | |   | || (\ \) |  | |   | ||  __)     | |   | ||  _____)| |   | ||  ___  |   | |   |  __)   (_____  )
//       ) || (      | |      | |         | |   | |   | || | \   |  | |   ) || (        | |   | || (      | |   ) || (   ) |   | |   | (            ) |
// /\____) || (____/\| (____/\| (____/\___) (___| (___) || )  \  |  | (__/  )| (____/\  | (___) || )      | (__/  )| )   ( |   | |   | (____/\/\____) |
// \_______)(_______/(_______/(_______/\_______/(_______)|/    )_)  (______/ (_______/  (_______)|/       (______/ |/     \|   )_(   (_______/\_______)
//******************************************************************************************************************************************************       

    public function UpdateCategoriaAnimal($id, $animal){

        $stmt = $this->connection->prepare("
        
        UPDATE `dbstore`.`categoria_animal`
        SET
        `animal` = '$animal'
        WHERE `categoria_animal_id` = $id;

       ");

        $stmt->execute(); 
    }


    public function UpdateCategoriaProducto($id,$producto){

        $stmt = $this->connection->prepare("
        UPDATE `dbstore`.`categoria_producto`
            SET
            `nombre` = '$producto'
            WHERE `categoria_producto_id` = $id;

        ");

        $stmt->execute(); 
    }

    public function UpdateMetodoPago($id,$nombre){

        $stmt = $this->connection->prepare("

            UPDATE `dbstore`.`metodo_pago`
            SET
            `nombre` = '$nombre'
            WHERE `metodo_pago_id` = $id;


        ");

        $stmt->execute(); 
    }



    public function UpdateCliente($id,$nombre,$identificacion,$tel,$correo,$direccion_envio,$información_dicional){

        $stmt = $this->connection->prepare("
        
        UPDATE `dbstore`.`cliente`
        SET
        `nombre` = '$nombre',
        `identificacion` = '$identificacion',
        `tel` = '$tel',
        `correo` = '$correo',
        `direccion_envio` = '$direccion_envio',
        `informacion_dicional` = '$información_dicional'
        WHERE `cliente_id` = '$id';
        
        ");

        $stmt->execute(); // ejecutamos la sentecia

    }

    public function UpdatePedido($id,$fecha_pedido,$cliente_id,$metodo_pago_id){

        $stmt = $this->connection->prepare("

            UPDATE `dbstore`.`pedido`
            SET
            `fecha_pedido` = '$fecha_pedido',
            `cliente_id` = $cliente_id,
            `metodo_pago_id` = $metodo_pago_id
            WHERE `id_pedido` = $id;
        
        
        ");

        $stmt->execute(); 
    }


    public function UpdatePedidoDetalle($id_pedido,$producto_id,$cantidad_producto){

        $stmt = $this->connection->prepare("

            UPDATE `dbstore`.`pedido_detalle`
            SET
            `cantidad_producto` = $cantidad_producto
            WHERE id_pedido = $id_pedido AND producto_id = $producto_id ;


        ");

        $stmt->execute(); 
    }



    public function UpdateProductos($id,$categoria_animal_id,$categoria_producto_id,$nombre,$marca,$descripcion,$precio,$stock,$codigo_barra,$imagenes,$garantia){

        $stmt = $this->connection->prepare("

            UPDATE `dbstore`.`producto`
            SET
            `categoria_animal_id` = $categoria_animal_id,
            `categoria_producto_id` = $categoria_producto_id,
            `nombre` = '$nombre',
            `marca` = '$marca',
            `descripcion` = '$descripcion',
            `precio` = $precio,
            `stock` = $stock,
            `codigo_barra` = '$codigo_barra',
            `imagenes` = '$imagenes',
            `garantia` = '$garantia'
            WHERE `producto_id` = $id;


        ");

        $stmt->execute(); // ejecutamos la sentecia

    }



    public function UpdateTipoUsuario($id,$nombre){

        $stmt = $this->connection->prepare("

            UPDATE `dbstore`.`tipo_usuario`
            SET
            `nombre` = '$nombre'
            WHERE `tipo_usuario_id` = $id;

        ");

        $stmt->execute(); 
    }




    public function UpdateUsuario($id,$nombre,$password,$tipo_usuario_id){

        $stmt = $this->connection->prepare("

        UPDATE `dbstore`.`usuario`
        SET
        `nombre` = '$nombre',
        `password` = '$password',
        `tipo_usuario_id` = '$tipo_usuario_id'
        WHERE `usuario_id` = $id;
 
        

        ");

        $stmt->execute(); 
    }
    

//******************************************************************************************************************************************************
//  _______  _______  _______  _______ _________ _______  _          ______   _______    ______   _______  _        _______ _________ _______  _______ 
// (  ____ \(  ____ \(  ____ \(  ____ \\__   __/(  ___  )( (    /|  (  __  \ (  ____ \  (  __  \ (  ____ \( \      (  ____ \\__   __/(  ____ \(  ____ \
// | (    \/| (    \/| (    \/| (    \/   ) (   | (   ) ||  \  ( |  | (  \  )| (    \/  | (  \  )| (    \/| (      | (    \/   ) (   | (    \/| (    \/
// | (_____ | (__    | |      | |         | |   | |   | ||   \ | |  | |   ) || (__      | |   ) || (__    | |      | (__       | |   | (__    | (_____ 
// (_____  )|  __)   | |      | |         | |   | |   | || (\ \) |  | |   | ||  __)     | |   | ||  __)   | |      |  __)      | |   |  __)   (_____  )
//       ) || (      | |      | |         | |   | |   | || | \   |  | |   ) || (        | |   ) || (      | |      | (         | |   | (            ) |
// /\____) || (____/\| (____/\| (____/\___) (___| (___) || )  \  |  | (__/  )| (____/\  | (__/  )| (____/\| (____/\| (____/\   | |   | (____/\/\____) |
// \_______)(_______/(_______/(_______/\_______/(_______)|/    )_)  (______/ (_______/  (______/ (_______/(_______/(_______/   )_(   (_______/\_______)
//******************************************************************************************************************************************************

    

    public function DeleteCategoriaAnimal($id){

        $stmt = $this->connection->prepare("

            DELETE FROM `dbstore`.`categoria_animal`
            WHERE categoria_animal_id = $id;

        ");

        $stmt->execute(); 
    }



    public function DeleteCategoriaProducto($id){

        $stmt = $this->connection->prepare("

            DELETE FROM `dbstore`.`categoria_producto`
            WHERE categoria_producto_id = $id;
        
        ");


        $stmt->execute(); 
    }

    public function DeleteCliente($id){

        $stmt = $this->connection->prepare("

            DELETE FROM `dbstore`.`cliente`
            WHERE cliente_id = $id;

        ");

        $stmt->execute(); 
    }

    public function DeleteMetodoPago($id){

        $stmt = $this->connection->prepare("

            DELETE FROM `dbstore`.`metodo_pago`
            WHERE metodo_pago_id = $id;
        

        ");

        $stmt->execute(); 
    }

    public function DeletePedido($id){

        $stmt = $this->connection->prepare("

            DELETE FROM `dbstore`.`pedido`
            WHERE id_pedido = $id;
        
        ");

    
        $stmt->execute(); 
    }

    public function DeletePedidoDetalle($id_pedido, $producto_id){

        $stmt = $this->connection->prepare("

            DELETE FROM `dbstore`.`pedido_detalle`
            WHERE id_pedido = $id_pedido AND producto_id = $producto_id; 


        ");

        $stmt->execute(); 
    }

    public function DeletePedidoDetalleAll($id_pedido){

        $stmt = $this->connection->prepare("

            DELETE FROM `dbstore`.`pedido_detalle`
            WHERE id_pedido = $id_pedido; 
        ");

        $stmt->execute(); 
    }

    public function DeleteProducto($id){

        $stmt = $this->connection->prepare("
            DELETE FROM `dbstore`.`producto`
            WHERE producto_id = $id;

        ");


        $stmt->execute(); 
    }

    public function DeleteTipoUsuario($id){

        $stmt = $this->connection->prepare("

            DELETE FROM `dbstore`.`tipo_usuario`
            WHERE tipo_usuario_id = $id;
        

        ");

        $stmt->execute(); 
    }

    public function DeleteUsuario($id){

        $stmt = $this->connection->prepare("

            DELETE FROM `dbstore`.`usuario`
            WHERE usuario_id = $id;
        

        ");


        $stmt->execute(); 
    }

//******************************************************************************************************************************************************
//  _______          _________ _______  _______   _________ _______  ______   _        _______ 
// (  ____ \|\     /|\__   __/(  ____ )(  ___  )  \__   __/(  ___  )(  ___ \ ( \      (  ____ \
// | (    \/( \   / )   ) (   | (    )|| (   ) |     ) (   | (   ) || (   ) )| (      | (    \/
// | (__     \ (_) /    | |   | (____)|| (___) |     | |   | (___) || (__/ / | |      | (__    
// |  __)     ) _ (     | |   |     __)|  ___  |     | |   |  ___  ||  __ (  | |      |  __)   
// | (       / ( ) \    | |   | (\ (   | (   ) |     | |   | (   ) || (  \ \ | |      | (      
// | (____/\( /   \ )   | |   | ) \ \__| )   ( |     | |   | )   ( || )___) )| (____/\| (____/\
// (_______/|/     \|   )_(   |/   \__/|/     \|     )_(   |/     \||/ \___/ (_______/(_______/
//******************************************************************************************************************************************************



    public function getPedidoEstadoAll(){

        $stmt = $this->connection->prepare("
        SELECT `pedido_estado`.`pedido_id`,
        `pedido_estado`.`estado_id`
       
        FROM `dbstore`.`pedido_estado`;
        ");

        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getPedidoEstado($id){

        $stmt = $this->connection->prepare("
        SELECT `pedido_estado`.`pedido_id`,
        `pedido_estado`.`estado_id`
      
        FROM `dbstore`.`pedido_estado`
        WHERE pedido_id = $id;
        ");

        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    

    public function getEstadoAll(){

        $stmt = $this->connection->prepare("
        SELECT `estado`.`estado_id`,
        `estado`.`nombre`
        FROM `dbstore`.`estado`;
        ");

        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function getEstado($id){

        $stmt = $this->connection->prepare("
        SELECT `estado`.`estado_id`,
        `estado`.`nombre`
        FROM `dbstore`.`estado`
        WHERE estado_id = $id;
        ");

        $stmt->execute(); // ejecutamos la sentecia

        //hacer un fecth de todos los resultados
        $resultado = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $resultado;
    }

    public function InsertPedidoEstado($pedido_id,$estado_id){

        $stmt = $this->connection->prepare("

        INSERT INTO `dbstore`.`pedido_estado`
        (`pedido_id`,
        `estado_id`
        )
        VALUES
        (?,?);

        ");

        $params = [$pedido_id,$estado_id];
        $stmt->execute($params); 
    }

    public function InsertEstado($nombre){

        $stmt = $this->connection->prepare("

        INSERT INTO `dbstore`.`estado`
        (`nombre`)
        VALUES
        (?);
        "
        );

        $params = [$nombre];
        $stmt->execute($params); 
    }

    public function DeleteEstado($id){

        $stmt = $this->connection->prepare("

        DELETE FROM `dbstore`.`estado`
        WHERE estado_id = $id;
        ");

        $stmt->execute(); // ejecutamos la sentecia

    }

    public function DeletePedidoEstado($id){

        $stmt = $this->connection->prepare("

        DELETE FROM `dbstore`.`pedido_estado`
        WHERE pedido_id = $id;

        ");

        $stmt->execute(); // ejecutamos la sentecia
    }


    public function UpdateEstado($estado_id,$nombre){

        $stmt = $this->connection->prepare("

        UPDATE `dbstore`.`estado`
        SET
        `nombre` = '$nombre'
        WHERE `estado_id` = $estado_id;
        

        ");

        $stmt->execute(); 
    }

    public function UpdatePedidoEstado($pedido_id,$estado_id,){

        $stmt = $this->connection->prepare("

        UPDATE `dbstore`.`pedido_estado`
        SET
        `estado_id` = $estado_id
        WHERE `pedido_id` = $pedido_id;
                

        ");

        $stmt->execute(); 
    }





}


