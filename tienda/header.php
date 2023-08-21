
<header>
<nav class="navbar navbar-expand-lg navbar-light bg-info  ">
  <a class="navbar-brand" href="#"><img src="./img/logo.jpg" width="35" height="35" alt="Logo" class="m-1"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavP">
    <form class="flex-grow-1">
      <div class="input-group">
        <!-- <input type="text" class="form-control flex-grow-1" placeholder="Buscar productos"> -->
        <div class="input-group-append">
          <!-- <button class="btn btn-outline-secondary" type="button">Buscar</button> -->
        </div>
      </div>
    </form>

    <button type="button" id="contador_carrito" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#cartModal">
        <i class="fas fa-shopping-cart"></i>
    </button>

  </div>
</nav>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="http://localhost/tienda/">Inicio</a>
    
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse"  id="navbarNav">
      <!-- <ul class="navbar-nav">
        
       
        <li class="nav-item dropdown" id="menuAnimales">
          <a class="nav-link dropdown-toggle" data-bs-auto-close="outside" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Productos
          </a>
          <ul class="dropdown-menu">
            <li class="dropend">
                <a class="dropdown-item dropdown-toggle" data-bs-toggle="dropdown" href="#">Pero</a>

                <ul class="dropdown-menu">
                    
                <li> <a href="" class="dropdown-item">Alimentos</a> </li>
                </ul>

            </li>
            <li><a class="dropdown-item" href="#">Gato</a></li>
            <li><a class="dropdown-item" href="#">Otros</a></li>
          </ul>
        </li>


        <li class="nav-item">
          <a class="nav-link" href="#">Contacto</a>
        </li>
        
      </ul> -->
    </div>
  </div>
</nav>



 
    <!-- Modal -->
    <div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="cartModalLabel">Carrito de Compras</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body" id="carritoModal">
            
          

          </div>
          <div class="modal-footer">
            <button type="button" id="pedidobtb" class="btn btn-primary"  onclick="window.location.href='http://localhost/tienda/compra.php'" >Hacer Pedido</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
          </div>
        </div>
      </div>
    </div>

  </header>

  <script src="/tienda/js/carrito.js"></script>
  <script src="/tienda/js/header.js"></script>
  

