import 'package:flutter/material.dart';
import '../models/metodo_pago_model.dart';
import '../providers/metodo_pago_provider.dart'; // Asegúrate de importar correctamente tu provider

class MetodoPagoDropdown extends StatefulWidget {
  final ValueNotifier<String?> valorSeleccionadoController;

  const MetodoPagoDropdown(
      {Key? key, required this.valorSeleccionadoController})
      : super(key: key);

  @override
  MetodoPagoDropdownState createState() => MetodoPagoDropdownState();
}

class MetodoPagoDropdownState extends State<MetodoPagoDropdown> {
  final metodoPagoProvider = MetodoPagoProvider();
  List<MetodoPago> metodosPago = [];
  String? valorSeleccionado;

  @override
  void initState() {
    super.initState();
    obtenerMetodosPago(); // Llamamos a la función para obtener los métodos de pago
  }

  void obtenerMetodosPago() async {
    try {
      final metodos = await metodoPagoProvider.obtenerMetodosPago();
      setState(() {
        metodosPago = metodos;
      });
    } catch (error) {
      print('Error al obtener métodos de pago: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.valorSeleccionadoController.value,
      hint: const Text(
          'Seleccione un método de pago'), // Texto que se muestra cuando no se ha seleccionado nada
      items: metodosPago.map((MetodoPago metodo) {
        return DropdownMenuItem<String>(
          value: metodo.metodo_pago_id.toString(),
          child: Text(metodo.nombre),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          widget.valorSeleccionadoController.value = newValue;
          //print(newValue);
        });
      },
    );
  }
}
