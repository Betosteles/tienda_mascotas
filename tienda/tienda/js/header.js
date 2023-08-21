const menu = document.getElementById("navbarNav");
let productosAgregados = false;

fetch(`http://localhost/api/CategoriaAnimal/?id=0`)
  .then(response => response.json())
  .then(categoriasAnimal => {
    const promises = categoriasAnimal.map(a =>
      fetch(`http://localhost/api/CategoriaProducto/?id=0`)
        .then(response => response.json())
        .then(categoriasProducto => {
          const submenuContent = categoriasProducto.map(c =>
            `<li><a href="http://localhost/tienda/index.php?idA=${a.categoria_animal_id}&idC=${c.categoria_producto_id}" class="dropdown-item">${c.nombre}</a></li>`
          ).join('');

          return `
            <li class="dropend">
              <a class="dropdown-item dropdown-toggle" data-bs-toggle="dropdown" href="#"> ${a.animal}</a>
              <ul class="dropdown-menu">
                ${submenuContent}
              </ul>
            </li>
          `;
        })
    );

    Promise.all(promises)
      .then(menuContent => {
        // Agregar el menú "Productos" solo si aún no se ha agregado
        if (!productosAgregados) {
          menu.innerHTML += `
            <ul class="navbar-nav">
              <li class="nav-item dropdown" id="menuAnimales">
                <a class="nav-link dropdown-toggle" data-bs-auto-close="outside" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  Productos
                </a>
                <ul class="dropdown-menu">
                  ${menuContent.join('')}
                </ul>
              </li>
             
            </ul>
          `;
          productosAgregados = true;
        }
      });
  });


//   <li class="nav-item">
//   <a class="nav-link" href="http://localhost/tienda/contacto.php">Contacto</a>
// </li>




 


   
    

  
    

   

    function asasdasd(){
    const menu = document.getElementById("navbarNav")

    menu.innerHTML +=`
    
    <ul class="navbar-nav">
            
           
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
    
           </ul>
    
        `
    }