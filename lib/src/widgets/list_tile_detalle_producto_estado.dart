import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/pedido_detalle.dart';
import 'package:tienda_mascotas/src/models/pedido_estado.dart';
import 'package:tienda_mascotas/src/models/producto.dart';
import 'package:tienda_mascotas/src/providers/pedido_estado_provider.dart';

import 'list_tile_pedido_detalle_final.dart';

class ListTilePedidoDetalleEstado extends StatelessWidget {
  ListTilePedidoDetalleEstado(
      {super.key, required this.pedidoDetalle, required this.productoDetalle});

  final PedidoDetalle pedidoDetalle;
  final Producto productoDetalle;
  final pedidoEstadoProvider = PedidoEstadoProvide();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PedidoEstado>(
      future: pedidoEstadoProvider.getPedidoEstado(pedidoDetalle.idPedido),
      builder: (BuildContext context, AsyncSnapshot<PedidoEstado> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final pedidoEstado = snapshot.data;

          if (pedidoEstado != null) {
            return ListTilePedidoDetalleFinal(
                pedidoDetalle: pedidoDetalle,
                productoDetalle: productoDetalle,
                pedidoEstado: pedidoEstado);
          } else {
            return const Text('');
          }
        }
      },
    );
  }
}
