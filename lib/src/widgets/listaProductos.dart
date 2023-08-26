import 'package:flutter/material.dart';
import '../models/producto.dart';
import 'itemProduct.dart';

class ListaProductos extends StatelessWidget {
  const ListaProductos({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot<List<Producto>> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.data!.isEmpty) {
      return const Center(
        child: Text("No se encontraron Productos"),
      );
    }

    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final product = snapshot.data![index];

        return ItemProduct(product: product);
      },
    );
  }
}
