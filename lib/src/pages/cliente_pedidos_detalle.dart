import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/pedido_detalle.dart';

import '../constantes/tema.dart';
import '../models/pedido.dart';
import '../providers/pedido_detalle_provider.dart';
import '../widgets/list_tile_pedido_detalle_producto.dart';
import '../widgets/total_text.dart';

class ClientesPedidosDetallePage extends StatelessWidget {
  const ClientesPedidosDetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidoDetalleProvider = PedidoDetalleProvider();
    final args = ModalRoute.of(context)!.settings.arguments as Pedido;

    return Scaffold(
        appBar: getAppBarStyle('Ver Pedidos'),
        body: FutureBuilder<List<PedidoDetalle>>(
          future: pedidoDetalleProvider.getPedidoDetalle(args.idPedido),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
            } else if (snapshot.hasError) {
              return const Text(
                  'Error al cargar los pedidos'); // Muestra un mensaje de error si hay un problema
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text(
                  'No hay pedidos disponibles'); // Muestra un mensaje si no hay datos disponibles
            } else {
              return Column(children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          PedidoDetalle detalle = snapshot.data![index];
                          return GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    ListTilePedidoDetalleProducto(
                                      pedidoDetalle: detalle,
                                    ),
                                  ],
                                ),
                              ));
                        })),
                TextTotal(
                  pedidoid: args.idPedido,
                ),
              ]);
            }
          },
        ));
  }
}
