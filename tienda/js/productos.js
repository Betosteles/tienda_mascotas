function getid(idP) {
  // Aquí dentro se ejecuta la función que deseas llamar cuando se hace clic en el botón
  window.location.href = `http://localhost/tienda/productos.php?id=${idP}`;
  
}

function addProduct(id){

  fetch(`http://localhost/api/Producto/?id=${id}`)
  .then(response => response.json())
  .then(producto => {
    // Agregar el producto al carrito
    let carrito = JSON.parse(localStorage.getItem('carrito')) || [];

 
      carrito.push(producto);


    localStorage.setItem('carrito', JSON.stringify(carrito));
  });

  
}


const urlParams = new URLSearchParams(window.location.search);

// Verificar si existe un parámetro llamado "id"
if (urlParams.has("idA") && urlParams.has("idC")) {
  // El parámetro "id" existe
  // Obtener su valor utilizando el método get()
  const idA = urlParams.get("idA");
  const idC = urlParams.get("idC");


  console.log(`El valor de "idA" es ${idA}`);
  console.log(`El valor de "idC" es ${idC}`);

  fetch(`http://localhost/api/Producto/?idA=${idA}&idC=${idC}`)
  .then(response => response.json())
  .then(productos => {


  
    const container = document.getElementById('productos-container'); 
    let tarjeta = ''
    let count = 0
    const i1 = '<div class="container text-center">'
    const i2 = '<div class="row align-items-center">'
    const f1 = '</div></div>'

    if (productos.length === 0) {
      container.innerHTML = "<h2>No hay artículos disponibles en este momento.</h2>";
      return
    } 

    productos.forEach(producto => {

      if (count==0){
        tarjeta += i1+i2  
      }
      
      tarjeta += `
      <div class="col-3" >
          <div class="card">
            <img src="/tienda/img/${producto.imagenes}" class="card-img-top" width="150" height="150" alt="${producto.nombre}" onclick="getid(${producto.producto_id})">
            <div class="card-body">
            <h5 class="card-title">${producto.nombre}</h5>
            <p class="card-text">${producto.descripcion}</p>
            <p class="card-text">Precio: ${producto.precio} Lps.</p>
            <button onclick="addProduct(${producto.producto_id}); setTimeout(() => contarCarrito(), 200)">Añadir Al Carrito</button>

        </div>
      </div>
    </div>
    `

    if (count==3){
      tarjeta +=f1
      count=0  
      return      
    }
    count++

    });

    container.innerHTML = tarjeta;
  });




} else {
  fetch('http://localhost/api/Producto/?id=0')
  .then(response => response.json())
  .then(productos => {
    const container = document.getElementById('productos-container'); 
    let tarjeta = ''
    let count = 0
    const i1 = '<div class="container text-center">'
    const i2 = '<div class="row align-items-center">'
    const f1 = '</div></div>'
    productos.forEach(producto => {

      if (count==0){
        tarjeta += i1+i2  
      }
      
      tarjeta += `
      <div class="col-3" >
          <div class="card">
            <img src="/tienda/img/${producto.imagenes}" class="card-img-top" width="150" height="150" alt="${producto.nombre}" onclick="getid(${producto.producto_id})">
            <div class="card-body">
            <h5 class="card-title">${producto.nombre}</h5>
            <p class="card-text">${producto.descripcion}</p>
            <p class="card-text">Precio: ${producto.precio} Lps.</p>
            <button onclick="addProduct(${producto.producto_id}); setTimeout(() => contarCarrito(), 200)">Añadir Al Carrito</button>

        </div>
      </div>
    </div>
    `

    if (count==3){
      tarjeta +=f1
      count=0  
      return      
    }
    count++

    });

    container.innerHTML = tarjeta;
  });

}




