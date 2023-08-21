
const lista = document.getElementById("metodoPago")



  fetch(`http://localhost/api/MetodoPago/?id=0`)
    .then(response => response.json())
    .then(respuesta => {
      respuesta.forEach(Metodo =>{

        lista.innerHTML += `<option value="${Metodo.metodo_pago_id}">${Metodo.nombre}</option>`
        console.log(Metodo.nombre)
  
  
    })
    })






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

function contarCarrito2() {
    
    const boton = document.getElementById('botonEnviar');
   
    const carro = document.getElementById("carritoPedido");
    const carrito = JSON.parse(localStorage.getItem("carrito")) || [];
   
   
  
    carro.innerHTML = "<h2>Carrito</h2>";
  
    if (carrito.length == 0) {

      carro.innerHTML = "Aún no hay nada en el carrito.";
      boton.disabled = true;
     

    } else {

    
      boton.disabled = false;
          
      const carrito_unificado = uniqueCarrito();
      const cantidad = contar();
  
      let total = 0;
  
      carro.innerHTML += `
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

function procesarFormulario() {

    const postData = (url, data) => {
    return new Promise((resolve, reject) => {
      fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          
        },
        body: JSON.stringify(data)
      })
        .then(response => response.json())
        .then(data => resolve(data))
        .catch(error => reject(error));
    });

  };



  const postData2 = (url, data) => {
    return new Promise((resolve, reject) => {
      fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          
        },
        body: JSON.stringify(data)
      })
        .then(response => response.text())
        .then(data => resolve(data))
        .catch(error => reject(error));
    });

  };


  

 

 

    // Obtener los valores de los campos del formulario
    var nombreF = document.getElementById("nombreCompleto").value;
    var identidadF = document.getElementById("identidad").value;
    var telefonoF = document.getElementById("telefono").value;
    var correoF = document.getElementById("correo").value;
    var direccionF = document.getElementById("direccion").value;
    var referenciaF = document.getElementById("referencia").value;
    

    // let formData = new FormData()
    // formData.append("nombre", "Kevin Alva")
    // formData.append("identificacion", "0502199800566")
    // formData.append("tel", "98289289")
    // formData.append("correo", "kevin.alva@unah.hn")
    // formData.append("direccion_envio", "Choloma Cortes Col Ficticia 1 calle 1 ave")
    // formData.append("información_dicional", "Enfrente del Campo Ficticio")
 

//     fetch('http://localhost/api/Cliente/', {
//   method: 'POST',
//   headers: {
//     'Content-Type': 'application/json'
//   },
//   body: JSON.stringify({
//     "nombre": "Kevin Alva",
//     "identificacion": "0502199800566",
//     "tel": "98289289",
//     "correo": "kevin.alva@unah.hn",
//     "direccion_envio": "Choloma Cortes Col Ficticia 1 calle 1 ave",
//     "información_dicional": "Enfrente del Campo Ficticio"
//   })
// })
// .then(response => response.text())
// .then(data => {
//   console.log(data);
// })
// .catch(error => {
//   console.error(error);
// });




    postData('http://localhost/api/Cliente/', { nombre: nombreF, identificacion: identidadF ,tel: telefonoF,correo: correoF,direccion_envio:direccionF,información_dicional:referenciaF})    
    .then(data => {  


      console.log("data:",data)
        const cliente_idF = data[data.length-1].cliente_id


        console.log("paso 1:",cliente_idF,lista.value)

        postData('http://localhost/api/Pedido/', { cliente_id: cliente_idF, metodo_pago_id: lista.value})
        .then(data => {
          const carrito = uniqueCarrito()
          const cantidades = contar()

          carrito.map((producto) => {
            const p = producto[0];
    
            const c = cantidades[producto[0].producto_id];
            console.log("paso 2", data[data.length-1].id_pedido,p.producto_id, c)
            
    
            postData2('http://localhost/api/PedidoDetalle/', { id_pedido: data[data.length-1].id_pedido, producto_id:p.producto_id ,cantidad_producto: c})
            .then(data => console.log(data))
            .catch(error => console.error(error));
    
            
      
    
    })   


        


        })
        .catch(error => console.error(error));

    })
    .catch(error => console.error(error));

 
    }


function vaciarCarrito(){

  // Obtener el carrito del localStorage
let carrito = JSON.parse(localStorage.getItem("carrito")) || [];

// Vaciar el carrito
carrito = [];

// Actualizar el localStorage con el nuevo valor de carrito
localStorage.setItem("carrito", JSON.stringify(carrito));

contarCarrito();
contarCarrito2()



}

function eliminarProducto(productoId) {
    let carrito = JSON.parse(localStorage.getItem("carrito")) || [];

    carrito = carrito.filter(p => p[0].producto_id != productoId);



    localStorage.setItem("carrito", JSON.stringify(carrito));
    contarCarrito();
    contarCarrito2()
  }


contarCarrito2()