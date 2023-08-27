import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/pedido_detalle.dart';
import 'package:tienda_mascotas/src/models/producto.dart';
import 'package:tienda_mascotas/src/providers/producto_provider.dart';

import 'list_tile_detalle_producto_estado.dart';

class ListTilePedidoDetalleProducto extends StatelessWidget {
  ListTilePedidoDetalleProducto({super.key, required this.pedidoDetalle});

  final PedidoDetalle pedidoDetalle;
  final productoProvider = ProductoProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Producto>(
      future: productoProvider.getProducto(pedidoDetalle.productoId),
      builder: (BuildContext context, AsyncSnapshot<Producto> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final productoDetalle = snapshot.data;

          if (productoDetalle != null) {
            return ListTilePedidoDetalleEstado(
              pedidoDetalle: pedidoDetalle,
              productoDetalle: productoDetalle,
            );

            //return ListTilePedidoDetalleEstado(pedidoDetalle: pedidoDetalle,productoDetalle: snapshot.data,);
          } else {
            return const Text('No hay datos de producto disponibles');
          }
        }
      },
    );
  }
}
