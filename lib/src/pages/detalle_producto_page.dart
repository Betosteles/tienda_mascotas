import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tienda_mascotas/src/VariableControler/total_amount_cart.dart';
import 'package:tienda_mascotas/src/constantes/tema.dart';

import '../VariableControler/amount_product_controller.dart';
import '../models/producto.dart';
import '../providers/carrito_provider.dart';
import '../widgets/snackbar_helper.dart';

class DetalleProducto extends StatelessWidget {
  DetalleProducto({super.key});

  final carritoProvider = CarritoService();
  final User? user = FirebaseAuth.instance.currentUser;
  final cantidad = Get.put<AmountProductController>(AmountProductController());

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Producto;
    final amountControler =
        Get.find<AmountProductController>(tag: args.productoId.toString());

    return FutureBuilder(
      future: carritoProvider
          .obtenerCantidadProductoEnCarrito(args.productoId.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No hay datos disponibles');
        } else {
          cantidad.currentAmount = snapshot.data!;

          return Scaffold(
            appBar: getAppBarStyle(args.nombre),
            body: Center(
              child: Column(
                children: [
                  Image.network(
                    args.imagenes,
                    height: 200,
                    fit: BoxFit.fitHeight,
                  ),
                  ListTile(
                    title: Text(args.descripcion),
                    subtitle: Text('Marca: ${args.marca}'),
                  ),
                  ListTile(
                    title: Text('Stock: ${args.stock}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${args.precio}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (cantidad.currentAmount > 0) {
                                  cantidad.currentAmount--;
                                }
                              },
                            ),
                            Obx(() => Text(cantidad.currentAmount.toString())),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                if (cantidad.currentAmount < args.stock) {
                                  cantidad.currentAmount++;
                                }
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Lógica para agregar al carrito
                            if (cantidad.currentAmount != 0) {
                              await carritoProvider
                                  .agregarProductoAlCarrito(
                                      user!.uid,
                                      args.productoId,
                                      cantidad.currentAmount,
                                      args.precio)
                                  .then((value) {
                                SnackBarHelper.showSnackBar(
                                    context,
                                    'Producto Actualizado Correctamente',
                                    SnackBarType.info,
                                    duration: const Duration(seconds: 1));
                                amountControler.currentAmount =
                                    cantidad.currentAmount;
                                refreshAmount();
                                sleep(const Duration(milliseconds: 350));
                                Navigator.pop(context);
                              });
                            } else if (cantidad.currentAmount == 0) {
                              await carritoProvider
                                  .eliminarProductoDelCarrito(
                                      user!.uid, args.productoId.toString())
                                  .then((value) {
                                SnackBarHelper.showSnackBar(
                                    context,
                                    'Producto Actualizado Correctamente',
                                    SnackBarType.info,
                                    duration: const Duration(seconds: 1));
                                amountControler.currentAmount =
                                    cantidad.currentAmount;
                                refreshAmount();
                              });
                            }
                          },
                          child: const Text(
                            'Añadir al carrito',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
