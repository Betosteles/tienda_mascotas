import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/widgets/snackbar_helper.dart';
import '../providers/pedido_estado_provider.dart';

enum EstadosDePedidos { pendiente, completado }

class EstadoPedidoDropdown extends StatefulWidget {
  final ValueNotifier<String?> valorSeleccionadoController;
  final int pedidoId;

  const EstadoPedidoDropdown(
      {Key? key,
      required this.valorSeleccionadoController,
      required this.pedidoId})
      : super(key: key);

  @override
  EstadoPedidoDropdownState createState() => EstadoPedidoDropdownState();
}

class EstadoPedidoDropdownState extends State<EstadoPedidoDropdown> {
  final estadoPedidoProvider = PedidoEstadoProvide();
  EstadosDePedidos estadoPedidoEnum =
      EstadosDePedidos.pendiente; // Valor predeterminado
  List<int> pedidoEstados = [1, 2];

  @override
  void initState() {
    super.initState();
    obtenerEstado();
  }

  void obtenerEstado() async {
    try {
      final estado =
          await estadoPedidoProvider.getPedidoEstado(widget.pedidoId);

      setState(() {
        estadoPedidoEnum = estado.estadoId == 1
            ? EstadosDePedidos.pendiente
            : EstadosDePedidos.completado;
        widget.valorSeleccionadoController.value = estado.estadoId.toString();
      });
    } catch (error) {
      SnackBarHelper.showSnackBar(
          context, error.toString(), SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    //String estadoTexto = estadoPedidoEnum == EstadosDePedidos.pendiente ? "Pendiente" : "Completado";

    return DropdownButton<String>(
      value: widget.valorSeleccionadoController.value,
      hint: const Text('Seleccione un estado de pedido'),
      items: pedidoEstados.map((int estado) {
        return DropdownMenuItem<String>(
          value: estado.toString(),
          child: Text(estado == 1 ? "Pendiente" : "Completado"),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          widget.valorSeleccionadoController.value = newValue;
          estadoPedidoEnum = newValue == "1"
              ? EstadosDePedidos.pendiente
              : EstadosDePedidos.completado;
        });
      },
    );
  }
}
