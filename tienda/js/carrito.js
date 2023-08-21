function contar(){
 
    const carrito = JSON.parse(localStorage.getItem('carrito')) || [];
  

    const contador = {};

  carrito.forEach(producto => {
    let id = producto[0].producto_id;
    if (contador[id]) {
      contador[id]++;
    } else {
      contador[id] = 1;
    }
  });
  

  return contador;
  }

  function uniqueCarrito(){
    const  carrito = JSON.parse(localStorage.getItem('carrito')) || [];
  
    const uniqueCarrito = [];
    const ids = {};

    for (let i = 0; i < carrito.length; i++) {
    let item = carrito[i][0];
    if (!ids[item.producto_id]) {
        uniqueCarrito.push(carrito[i]);
        ids[item.producto_id] = true;
    }
    }


    
   return uniqueCarrito
}


function contarCarrito() {
    const boton = document.getElementById('pedidobtb');

    const carrito_boton = document.getElementById("contador_carrito");
    const carro = document.getElementById("carritoModal");
    const carrito = JSON.parse(localStorage.getItem("carrito")) || [];
    const total_productos = carrito.length;
    carrito_boton.innerHTML = `Carrito(${total_productos})`;
  
    carro.innerHTML = "";
  
    if (carrito.length == 0) {
      carro.innerHTML = "Aún no hay nada en el carrito.";
      boton.disabled = true;

    } else {
        boton.disabled = false;
        
      const carrito_unificado = uniqueCarrito();
      const cantidad = contar();
  
      let total = 0;
  
      carro.innerHTML = `
        <table class="table">
          <thead>
            <tr>
              <th>Producto</th>
              <th>Precio</th>
              <th>Cantidad</th>
              <th>Sub Total</th>
              <th></th>              
            </tr>
          </thead>
          <tbody id="cart-table">
            ${carrito_unificado
              .map((producto) => {
                const p = producto[0];
                const c = cantidad[producto[0].producto_id];
                const subtotal = p.precio * c;
                total += subtotal;
                return `
                <tr>
                  <td>${p.nombre}</td>
                  <td>${p.precio} lps.</td>
                  <td>${c}</td>
                  <td>${subtotal} lps.</td>
                  <td><button onclick="eliminarProducto(${p.producto_id})">Eliminar</button></td>
                </tr>`;
              })
              .join("")}
            <tr>
              <td colspan="3"><strong>Total:</strong></td>
              <td>${total} lps.</td>
              <td></td>
            </tr>
          </tbody>
          
        </table>
      `;
    }

    
  }
  
  
  function eliminarProducto(productoId) {
    let carrito = JSON.parse(localStorage.getItem("carrito")) || [];

    carrito = carrito.filter(p => p[0].producto_id != productoId);



    localStorage.setItem("carrito", JSON.stringify(carrito));
    contarCarrito();
  }
  
  


contarCarrito()









