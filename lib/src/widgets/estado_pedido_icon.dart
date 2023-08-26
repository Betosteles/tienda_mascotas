import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/providers/pedido_estado_provider.dart';

class IconEstadoPedido extends StatelessWidget {
  const IconEstadoPedido({super.key, required this.pedidoId});
  final int pedidoId;

  @override
  Widget build(BuildContext context) {
    final pedido = PedidoEstadoProvide();

    return FutureBuilder(
        future: pedido.getPedidoEstado(pedidoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
          } else if (snapshot.hasError) {
            return const Text(
                'Error al cargar el icono'); // Muestra un mensaje de error si hay un problema
          } else {
            final resultado = snapshot.data;

            if (resultado?.estadoId == 2) {
              return const Icon(Icons.circle, color: Colors.green);
            } else if (resultado?.estadoId == 1) {
              return const Icon(Icons.circle, color: Colors.orange);
            } else {
              return const Icon(Icons.circle, color: Colors.red);
            }
          }
        });
  }
}
