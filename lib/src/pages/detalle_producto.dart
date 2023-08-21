// import 'package:flutter/material.dart';

// import '../models/producto.dart';
// import '../providers/producto_provider.dart';

// class DetalleProducto extends StatelessWidget {
//   DetalleProducto({super.key});

//   // final int productoId; //obtener los datos de este ID
//   final productoProvider = ProductoProvider();

//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)!.settings.arguments as Producto;

//     productoProvider.getProducto(args.productoId).then((value) {
//       // print(value.toJson());
//     });

//     return Scaffold(
//         appBar: AppBar(
//           title: Text(args.nombre,
//           style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ) 
//           ),
//           backgroundColor: Colors.green[900],
//         ),
//         body: Center(
//           child: Column(
//             children: [
              
//               Image.network(
//                 args.imagenes,
//                 height: 200,
//                 fit: BoxFit.fitHeight,
//               ),
//               ListTile(
                
//               title: Text(args.descripcion),
//               subtitle:  Text('Marca: ${args.marca}'),
              

//             ),

//             ListTile(
//               title: Text('Stock: ${args.stock}'),
//             ),

            
            
            
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '\$${args.precio}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.remove),
//                         onPressed: () {},
//                       ),
//                       Text("0"),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Lógica para agregar al carrito
//                     },
//                     child: const Text('Añadir al carrito'),
//                   ),
//                 ],
//               ),
//             ),
      
        
        
//             ],
//             ),
//         )
        
//         );
//   }
// }