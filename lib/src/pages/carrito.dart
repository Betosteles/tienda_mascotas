import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:tienda_mascotas/src/models/carrito_model.dart';
import 'package:tienda_mascotas/src/widgets/snackbar_helper.dart';
import '../VariableControler/total_amount_cart.dart';
import '../models/producto.dart';
import '../providers/carrito_provider.dart';
import '../providers/hacer_pedido_provider.dart';
import '../providers/producto_provider.dart';
import '../widgets/dropdown_button_metodo_pago.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});

  @override
  CarritoPageState createState() => CarritoPageState();
}

class CarritoPageState extends State<CarritoPage> {
  final carritoProvider = CarritoService();
  final User? user = FirebaseAuth.instance.currentUser;
 
  final hacerPedido = HacerPedido();

   final ValueNotifier<String?> valorSeleccionadoController = ValueNotifier(null);



  late Future<Carrito> carritoFuture;

  @override
  void initState() {
    super.initState();
    carritoFuture = carritoProvider.obtenerCarrito();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrito',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[900],
      ),
      body: FutureBuilder<Carrito>(
        future: carritoFuture,
        builder: (BuildContext context, AsyncSnapshot<Carrito> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('No hay conexión'),
            );
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.items.isEmpty) {
             return const Center(
              child: Text('El carrito está vacío.'),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListaProductos(snapshot: snapshot, refresh: _refresh),
              ),
              MetodoPagoDropdown(valorSeleccionadoController: valorSeleccionadoController,),
              if (snapshot.data!.items.isNotEmpty)
                ElevatedButton(
                  onPressed: () async {

                    if(valorSeleccionadoController.value!=null){
                      await hacerPedido.hacerPedido(int.parse(valorSeleccionadoController.value!));
                      await carritoProvider.borrarCarrito(user!.uid);
                    }else{
                      SnackBarHelper.showSnackBar(context, "Seleccione Metodo de Pago", SnackBarType.error);
                    }

                    _refresh();
                  },
                  child: const Text('Hacer Pedido'),
                ),
            ],
          );
        },
      ),
    );
  }

  void _refresh() {
    setState(() {
      carritoFuture = carritoProvider.obtenerCarrito();
    });
  }
}

class ListaProductos extends StatelessWidget {
  const ListaProductos({super.key, 
    required this.snapshot,
    required this.refresh,
  });

  final AsyncSnapshot<Carrito> snapshot;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data!.items.length,
      itemBuilder: (context, index) {
        final entry = snapshot.data!.items.entries.toList()[index];
        final idProducto = entry.key;
        final cantidad = entry.value;

        return ItemProduct(
          producto: idProducto,
          cantidad: cantidad,
          refresh: refresh,
        );
      },
    );
  }
}

class ItemProduct extends StatelessWidget {
   ItemProduct({super.key, 
    required this.producto,
    required this.cantidad,
    required this.refresh,
  });

  final String producto;
  final dynamic cantidad;
  final VoidCallback refresh;
  final productoProvider = ProductoProvider();
  final User? user = FirebaseAuth.instance.currentUser;
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Producto>(
      future: productoProvider.getProducto(int.parse(producto)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No hay datos disponibles');
        } else {
          final datosProducto = snapshot.data!;
          final carritoProvider = CarritoService();

          return ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(datosProducto.imagenes, fit: BoxFit.cover),
            ),
            title: Text(datosProducto.nombre),
            subtitle: Text(datosProducto.descripcion),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$cantidad'),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () async {
                    await carritoProvider.eliminarProductoDelCarrito(
                        user!.uid, datosProducto.productoId.toString());
                    refresh();

                    refreshAmount(); // Llamar al método de actualización
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(216, 255, 17, 0)),
                  icon: const Icon(Icons.delete, color: Color.fromARGB(255, 47, 68, 189)),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:tienda_mascotas/src/models/carrito_model.dart';
// import '../models/producto.dart';
// import '../providers/carrito_provider.dart';
// import '../providers/producto_provider.dart';

// class CarritoPage extends StatelessWidget {
//   const CarritoPage({super.key});


//   @override
//   Widget build(BuildContext context) {
//     final carritoProvider = CarritoService();
    
//     // final users = userProvider.getUsers();
//     // print(users);
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Carrito',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ) // Peso de fuente opcional
//               ),
//           backgroundColor: Colors.green[900],
//         ),
         
    
//         body: FutureBuilder<Carrito>(
//           future: carritoProvider.obtenerCarrito(),
//           builder:
//               (BuildContext context, AsyncSnapshot<Carrito> snapshot) {
//             if (snapshot.connectionState == ConnectionState.none) {
//               return const Center(
//                 child: Text('No hay conexion'),
//               );
//             }
//             if (snapshot.hasError) {


//             }
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }
    
//             return ListaProductos(snapshot: snapshot);
//           },
//         ),
//       );
//   }
// }

// class ListaProductos extends StatelessWidget {
//   const ListaProductos({
//     super.key,
//     required this.snapshot,
//   });

//   final AsyncSnapshot<Carrito> snapshot;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: snapshot.data!.items.length,
//       itemBuilder: (context, index) {
//         final entry = snapshot.data!.items.entries.toList()[index];
//         final idProducto = entry.key;
//         final cantidad = entry.value;

//         return ItemProduct(producto: idProducto, cantidad: cantidad);
//       },
//     );
//   }
// }

// class ItemProduct extends StatelessWidget {
//  ItemProduct({
//     super.key,
//     required this.producto,
//     required this.cantidad,
//   });

//   final productoProvider = ProductoProvider();

//   final String producto;
//   final dynamic cantidad;
//   final User? user = FirebaseAuth.instance.currentUser;

  
  

//   @override
//   Widget build(BuildContext context) {
//     //final cantidad = Get.put<AmountProductController>(AmountProductController(), tag: product.productoId.toString());
//     return FutureBuilder<Producto>(
//       future: productoProvider.getProducto(int.parse(producto)),
//       builder:(context, snapshot) {

//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const CircularProgressIndicator();
//       } else if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');
//       } else if (!snapshot.hasData) {
//         return const Text('No hay datos disponibles');
//       } else {
//         final datosProducto = snapshot.data!;
//         final carritoProvider = CarritoService();

//         return ListTile(
//               contentPadding: const EdgeInsets.all(16.0), // Agregar padding
//               leading: SizedBox(
//                 width: 50, // Ancho de la imagen
//                 height: 50, // Alto de la imagen
//                 child: Image.network(datosProducto.imagenes, fit: BoxFit.cover), // Ajuste de la imagen
//               ),
//               title: Text(datosProducto.nombre),
//               subtitle: Text(datosProducto.descripcion),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('$cantidad'),
//                   const SizedBox(width: 10), // Espacio entre la cantidad y el botón
//                   IconButton (
//                     onPressed:  () async {

//                       await carritoProvider.eliminarProductoDelCarrito(user!.uid,datosProducto.productoId.toString());
                      
                      
//                     },
//                     style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(216, 255, 17, 0)),
//                     icon: const Icon(Icons.delete, color: Color.fromARGB(255, 47, 68, 189)),
//                   ),
//                   ]
//                   )
      
//             );
//       }
//     },
//   );
// }
// }
