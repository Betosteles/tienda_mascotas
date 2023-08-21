<!DOCTYPE html>
<html>
<head>
	<title>Formulario de compra</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="/tienda/img/logo.jpg" type="image/png">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    
	<!-- Script de JS para la comprobación -->
	
</head>
<body class="mr-2 ml-2">

<?php include('header.php'); ?>

<style> 
#principal {
  min-height: 820px;
}
</style>

	<div id="principal" class="container pb-5">
		<div class="row">
			<div class="col-md-8">
				<h2>Formulario de compra</h2>
				<form  action="" name="compraForm" onsubmit="procesarFormulario(); setTimeout(vaciarCarrito, 1500); return false;">
					<div class="form-group">
						<label for="nombreCompleto">Nombre Completo:</label>
						<input type="text" class="form-control" id="nombreCompleto" placeholder="Introduce tu nombre completo" name="nombreCompleto">
					</div>
					<div class="form-group">
						<label for="identidad">Identidad:</label>
						<input type="text" class="form-control" id="identidad" placeholder="Introduce tu identidad Sin Guiones o Espacios" name="identidad">
					</div>
					<div class="form-group">
						<label for="telefono">Teléfono:</label>
						<input type="text" class="form-control" id="telefono" placeholder="Introduce tu número de teléfono Sin Guiones o Espacios" name="telefono">
					</div>

					<div class="form-group">
						<label for="correo">Email:</label>
						<input type="text" class="form-control" id="correo" placeholder="Introduce tu Correo Electronico" name="telefono">
					</div>

					<div class="form-group">
						<label for="direccion">Dirección:</label>
						<input type="text" class="form-control" id="direccion" placeholder="Introduce tu dirección" name="direccion">
					</div>

                    <div class="form-group">
                    <label for="referencia">Referencia:</label>
                    <textarea id="referencia" name="referencia" placeholder="Introduce una referencia para encontrar tu domicilio" class="form-control"></textarea>
                    </div>

					<div class="form-group">
						<label for="metodoPago">Método de pago:</label>
						<select class="form-control" id="metodoPago" name="metodoPago">
						
						
							

						</select>
					</div>
					<button id="botonEnviar" type="submit" class="btn btn-primary">Enviar</button>
				</form>
			</div>

			<div id="carritoPedido" class="col-md-4" >
				
				<!-- Aquí irá la lista de productos del carrito -->
				
			</div>
		</div>
	</div>

    <?php include('footer.php'); ?> 

	<script src="/tienda/js/pedido.js"></script>
</body>
</html>


