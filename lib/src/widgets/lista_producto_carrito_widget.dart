import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/widgets/item_product_widget.dart';

import '../models/carrito_model.dart';

class ListaProductos extends StatelessWidget {
  const ListaProductos({
    super.key,
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
