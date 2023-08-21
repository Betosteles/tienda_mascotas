const urlParams = new URLSearchParams(window.location.search);
const id = urlParams.get('id');

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

const miPromesa = () => {
  return new Promise((resolve, reject) =>{
    fetch(`http://localhost/api/Producto/?id=${id}`)
      .then(response => response.json())
      .then(data => {
        resolve(data);
      })
    })
}

fetch(`http://localhost/api/Producto/?id=${id}`)
  .then(response => response.json())
  .then(productos => {
    

    miPromesa().then((respuesta) => {
      const animal = respuesta[0].categoria_animal_id;
      const categoria = respuesta[0].categoria_producto_id;
      let texto = "Animales > ";
                        
      const promesa = () => {
        return new Promise((resolve, reject) =>{
          fetch(`http://localhost/api/CategoriaAnimal/?id=${animal}`)
            .then(response => response.json())
            .then(data => {
              resolve(data);
            })
          })
      }

      promesa().then((respuesta) => {
        texto += `${respuesta[0].animal} > `;
        const promesa2 = () => {
          return new Promise((resolve, reject) =>{
            fetch(`http://localhost/api/CategoriaProducto/?id=${categoria}`)
              .then(response => response.json())
              .then(data => {
                resolve(data);
              })
            })
        }
        promesa2().then((respuesta) => {
          texto += `${respuesta[0].nombre}`;
          const producto = productos[0];

        document.getElementById("title").textContent = producto.nombre;
                        
        const panel = document.getElementById("producto_cont");

        const direccion = document.createElement('h2');
        direccion.classList.add('mt-5');
        
          direccion.textContent = texto;
          panel.appendChild(direccion);

          const contenedor = document.createElement('div');
          contenedor.classList.add('container');
          contenedor.classList.add('text-center');
          panel.appendChild(contenedor);
    
          const titulo = document.createElement('h1');
          titulo.classList.add('mt-5');
          titulo.textContent = producto.nombre;
          contenedor.appendChild(titulo);
                
          const imagen = document.createElement('img');
          imagen.classList.add('img-fluid');
          imagen.src = `/tienda/img/${producto.imagenes}`;
          imagen.alt = producto.nombre;
          contenedor.appendChild(imagen);
          imagen.width = 500;
          imagen.height = 500;
          imagen.alt = producto.nombre;
          contenedor.appendChild(imagen);
                    
          const descripcion = document.createElement('p');
          descripcion.classList.add('h4');
          descripcion.textContent = `Descripción: ${producto.descripcion}`;
          contenedor.appendChild(descripcion);

          const marca = document.createElement('p');
          marca.classList.add('h2');
          marca.textContent = `Marca: ${producto.marca}`;
          contenedor.appendChild(marca);
                
          const precio = document.createElement('p');
          precio.classList.add('h3');
          precio.textContent = `Precio: ${producto.precio} Lps.`;
          contenedor.appendChild(precio);

          const AgregarCarrito = document.createElement('button');
          AgregarCarrito.onclick = () => { 
                addProduct(`${producto.producto_id}`); 
                setTimeout(() => contarCarrito(), 200);
              };
          AgregarCarrito.textContent = "Añadir Al Carrito";
          contenedor.appendChild(AgregarCarrito)

          

          console.log(texto);
        })
      })

//       direccion.textContent = "Animales > Perro > Alimentos";
//       panel.appendChild(direccion);
        
     
    })
})
