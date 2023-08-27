import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/pedido_detalle.dart';

import '../models/pedido.dart';
import '../providers/pedido_detalle_provider.dart';
import '../providers/pedido_estado_provider.dart';
import '../widgets/list_view_administar_pedidos.dart';

class AdministrarPedidosPage extends StatelessWidget {
  const AdministrarPedidosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidoProvider = PedidoDetalleProvider();
    final pedidoEstadoProvider = PedidoEstadoProvide();
    final args = ModalRoute.of(context)!.settings.arguments as Pedido;
    final ValueNotifier<String?> valorSeleccionadoController2 =
        ValueNotifier("1");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar Pedidos'),
      ),
      body: FutureBuilder<List<PedidoDetalle>>(
        future: pedidoProvider.getPedidoDetalle(args.idPedido),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras se obtienen los datos
          } else if (snapshot.hasError) {
            return const Text(
                'Error al cargar los pedidos'); // Muestra un mensaje de error si hay un problema
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text(
                'No hay pedidos disponibles'); // Muestra un mensaje si no hay datos disponibles
          } else {
            return AdministarPedidoListView(
                args: args,
                snapshot: snapshot,
                valorSeleccionadoController2: valorSeleccionadoController2,
                pedidoEstadoProvider: pedidoEstadoProvider);
          }
        },
      ),
    );
  }
}
