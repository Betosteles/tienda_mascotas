import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/constantes/tema.dart';
import 'package:tienda_mascotas/src/providers/pedido_provider.dart';

import '../models/pedido.dart';
import '../widgets/list_tile_pedido_estado_usuario.dart';

class VerPedidosPasadosPage extends StatelessWidget {
  const VerPedidosPasadosPage({super.key});

// ID Pedido 	Fecha 	Cliente 	Total 	Metodo de Pago 	Estado

  @override
  Widget build(BuildContext context) {
    final pedidoProvider = PedidoProvider();

    return Scaffold(
      appBar: getAppBarStyle("Pedidos Pasados"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Pedido>>(
          future: pedidoProvider.getPedidosPorCliente2(),
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
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Pedido detalle = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTilePedidoEstadoUsuario(
                                pedidoDetalle: detalle),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
