import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/pedido_estado.dart';

import '../constantes/routes.dart';
import '../models/pedido.dart';
import '../providers/pedido_detalle_provider.dart';

class ListTilePedidoDetalleUsuario extends StatelessWidget {
  ListTilePedidoDetalleUsuario(
      {super.key, required this.pedidoDetalle, required this.pedidoEstado});

  final Pedido pedidoDetalle;
  final PedidoEstado pedidoEstado;
  final pedidoDetalleUsuario = PedidoDetalleProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: pedidoDetalleUsuario.getTotalPedido(pedidoDetalle.idPedido),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final productoDetalle = snapshot.data;

          if (productoDetalle != null) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MyRoutes.clientePedidos.name,
                  arguments: pedidoDetalle,
                );
              },
              child: ListTile(
                  shape: BeveledRectangleBorder(
                    side: const BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                      'Fecha del Pedido: ${pedidoDetalle.fechaPedido.toString()}'),
                  subtitle: Text("Total: ${productoDetalle.toString()}"),
                  trailing: Text("id:${pedidoDetalle.idPedido.toString()}")),
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
