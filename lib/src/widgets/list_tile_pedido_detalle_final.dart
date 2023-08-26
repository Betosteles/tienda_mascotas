import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/pedido_detalle.dart';
import 'package:tienda_mascotas/src/models/pedido_estado.dart';
import 'package:tienda_mascotas/src/models/producto.dart';

enum EstadosDePedidos {
    pendiente,
    completado
  }

class ListTilePedidoDetalleFinal extends StatelessWidget {
  const ListTilePedidoDetalleFinal({super.key, required this.pedidoDetalle, required this.productoDetalle, required this.pedidoEstado});

  final PedidoDetalle pedidoDetalle;
  final Producto productoDetalle;
  final PedidoEstado pedidoEstado;

  @override
  Widget build(BuildContext context) {

    return  ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(productoDetalle.imagenes , fit: BoxFit.cover),
            ),
            title: Text(productoDetalle.nombre),
            subtitle: Text(productoDetalle.descripcion ),
            trailing: Text("X${pedidoDetalle.cantidadProducto}"),
            
          );
  }
}