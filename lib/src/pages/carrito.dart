import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:tienda_mascotas/src/models/carrito_model.dart';
import 'package:tienda_mascotas/src/widgets/snackbar_helper.dart';
import '../VariableControler/total_amount_cart.dart';
import '../constantes/tema.dart';
import '../providers/carrito_provider.dart';
import '../providers/hacer_pedido_provider.dart';
import '../widgets/dropdown_button_metodo_pago.dart';
import '../widgets/lista_producto_carrito_widget.dart';
import '../widgets/test_total_factura.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});

  @override
  CarritoPageState createState() => CarritoPageState();
}

class CarritoPageState extends State<CarritoPage> {
  final carritoProvider = CarritoService();
  final User? user = FirebaseAuth.instance.currentUser;

  final hacerPedido = HacerPedido();

  final ValueNotifier<String?> valorSeleccionadoController =
      ValueNotifier(null);

  late Future<Carrito> carritoFuture;

  @override
  void initState() {
    super.initState();
    carritoFuture = carritoProvider.obtenerCarrito();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarStyle("Carrito"),
      body: FutureBuilder<Carrito>(
        future: carritoFuture,
        builder: (BuildContext context, AsyncSnapshot<Carrito> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('No hay conexión'),
            );
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.items.isEmpty) {
            return const Center(
              child: Text('El carrito está vacío.'),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListaProductos(snapshot: snapshot, refresh: _refresh),
              ),
              TotalCarritoWidget(),
              MetodoPagoDropdown(
                valorSeleccionadoController: valorSeleccionadoController,
              ),
              if (snapshot.data!.items.isNotEmpty)
                ElevatedButton(
                  onPressed: () async {
                    if (valorSeleccionadoController.value != null) {
                      await hacerPedido.hacerPedido(
                          int.parse(valorSeleccionadoController.value!));
                      await carritoProvider.borrarCarrito(user!.uid);

                      _refresh();

                      refreshAmount();

                      // ignore: use_build_context_synchronously
                      SnackBarHelper.showSnackBar(
                          context, "Pedido Enviado!", SnackBarType.info);
                    } else {
                      SnackBarHelper.showSnackBar(context,
                          "Seleccione Metodo de Pago", SnackBarType.error);
                    }

                    _refresh();
                  },
                  child: const Text('Hacer Pedido'),
                ),
            ],
          );
        },
      ),
    );
  }

  void _refresh() {
    setState(() {
      carritoFuture = carritoProvider.obtenerCarrito();
    });
  }
}
