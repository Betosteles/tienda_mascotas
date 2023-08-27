import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../VariableControler/total_amount_cart.dart';
import '../models/producto.dart';
import '../providers/carrito_provider.dart';
import '../providers/producto_provider.dart';

class ItemProduct extends StatelessWidget {
  ItemProduct({
    super.key,
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
          return const  Center(child: CircularProgressIndicator());
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(216, 255, 17, 0)),
                  icon: const Icon(Icons.delete,
                      color: Color.fromARGB(255, 47, 68, 189)),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
