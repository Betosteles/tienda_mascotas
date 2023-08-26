import 'package:flutter/material.dart';

import '../constantes/routes.dart';
import '../models/pedido.dart';
import 'estado_pedido_icon.dart';

class AdminListView extends StatelessWidget {
  const AdminListView({
    super.key,
    required this.snapshot,
  });

  final dynamic snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) {
        Pedido detalle = snapshot.data![index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              MyRoutes.adminPedidos.name,
              arguments: detalle,
            );
          },
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: BeveledRectangleBorder(
                      side: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text('Fecha: ${detalle.fechaPedido}'),
                    subtitle: Text(
                        'Pedido: ${detalle.idPedido},    Metodo De pago: ${detalle.metodoPagoId == 1 ? "Transferencia Bancaria" : detalle.metodoPagoId == 2 ? "Contra Entrega" : "Otro Metodo De pago"}'),
                    trailing: IconEstadoPedido(
                      pedidoId: detalle.idPedido,
                    ),
                    isThreeLine: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
