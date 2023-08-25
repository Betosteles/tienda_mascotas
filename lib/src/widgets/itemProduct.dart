

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../VariableControler/amount_product_controller.dart';
import '../constantes/routes.dart';
import '../models/producto.dart';
import '../providers/carrito_provider.dart';

class ItemProduct extends StatelessWidget {
 const ItemProduct({
    super.key,
    required this.product,
  });

  final Producto product;
  



@override
Widget build(BuildContext context) {
  final carritoProvider = CarritoService();
  final amountControler = Get.put<AmountProductController>(
    AmountProductController(),
    tag: product.productoId.toString(),
  );

  return FutureBuilder<int>(
    future: carritoProvider.obtenerCantidadProductoEnCarrito(product.productoId.toString()),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }

      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      final cantidadEnCarrito = snapshot.data ?? 0;
      amountControler.currentAmount = cantidadEnCarrito;

      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            MyRoutes.detalleProducto.name,
            arguments: product,
          );
        },
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(product.nombre),
                  trailing: cantidadEnCarrito > 0
                      ? Obx(() => Text(
                            "(${amountControler.currentAmount.toString()})",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ))
                      : const Text(""),
                ),
              ),
              Image.network(
                product.imagenes,
                height: 200,
                fit: BoxFit.fitHeight,
              ),
              ListTile(
                title: Text(product.descripcion),
                trailing: Text(
                  '\$${product.precio}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
}