import 'package:flutter/material.dart';

import '../providers/pedido_detalle_provider.dart';

class TextTotal extends StatelessWidget {
  const TextTotal({super.key, required this.pedidoid});
  final int pedidoid;

  @override
  Widget build(BuildContext context) {
    final pedidoDetalleProvider = PedidoDetalleProvider();

    return FutureBuilder(
        future: pedidoDetalleProvider.getTotalPedido(pedidoid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras se obtienen los datos
          } else if (snapshot.hasError) {
            return const Text(
                'Error al cargar los pedidos'); // Muestra un mensaje de error si hay un problema
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Total: ${snapshot.data.toString()}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        });
  }
}
