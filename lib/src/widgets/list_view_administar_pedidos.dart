import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/widgets/total_text.dart';

import '../constantes/routes.dart';
import '../models/pedido.dart';
import '../models/pedido_detalle.dart';
import '../providers/pedido_estado_provider.dart';
import 'card_user_info.dart';
import 'dropdown_button_estado_pedido.dart';
import 'list_tile_pedido_detalle_producto.dart';

class AdministarPedidoListView extends StatelessWidget {
  const AdministarPedidoListView({
    super.key,
    required this.args,
    required this.valorSeleccionadoController2,
    required this.pedidoEstadoProvider,
    required this.snapshot,
  });

  final Pedido args;
  final ValueNotifier<String?> valorSeleccionadoController2;
  final PedidoEstadoProvide pedidoEstadoProvider;
  final dynamic snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                ),
              );
            },
          ),
        ),
        UserInfoCard(
          uid: args.clienteId,
        ),
        TextTotal(
          pedidoid: args.idPedido,
        ),
        EstadoPedidoDropdown(
          valorSeleccionadoController: valorSeleccionadoController2,
          pedidoId: args.idPedido,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                final valor = valorSeleccionadoController2.value;

                if (valor != null) {
                  pedidoEstadoProvider.actualizarEstadoPedido(
                      args.idPedido, int.parse(valor), context);
                  Navigator.pushNamed(context, MyRoutes.admin.name);
                }
              },
              child: const Text("Guardar")),
        )
      ],
    );
  }
}
