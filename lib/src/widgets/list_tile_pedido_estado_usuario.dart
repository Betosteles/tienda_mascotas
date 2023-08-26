import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/pedido_estado.dart';

import '../models/pedido.dart';
import '../providers/pedido_estado_provider.dart';
import 'list_tile_pedido_detalle_usuario.dart';

class ListTilePedidoEstadoUsuario extends StatelessWidget {
  ListTilePedidoEstadoUsuario({super.key, required this.pedidoDetalle});

  final Pedido pedidoDetalle;
  final pedidoEstadoProvider = PedidoEstadoProvide();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PedidoEstado>(
      future: pedidoEstadoProvider.getPedidoEstado(pedidoDetalle.idPedido),
      builder: (BuildContext context, AsyncSnapshot<PedidoEstado> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final productoEstado = snapshot.data;

          if (productoEstado != null) {
            return  ListTilePedidoDetalleUsuario(pedidoDetalle: pedidoDetalle,pedidoEstado: productoEstado);
            

            //return ListTilePedidoDetalleEstado(pedidoDetalle: pedidoDetalle,productoDetalle: snapshot.data,);
          } else {
            return const Text('No hay datos de producto disponibles');
          }
        }
      },
    );
  }
}
