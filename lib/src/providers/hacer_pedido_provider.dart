import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'carrito_provider.dart';

class HacerPedido {
  final String apiUrl = 'http://140.84.182.78/api';
  final carritoProvider = CarritoService();
  final User? user = FirebaseAuth.instance.currentUser;

  Future hacerPedido(int metodoPagoId) async {
    // Datos del pedido
    final clienteId = user!.uid; // Ajusta el ID del cliente existente
    final carro = await carritoProvider.obtenerCarrito();

    try {
      final pedidoResponse = await http.post(Uri.parse('$apiUrl/Pedido/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'cliente_id': clienteId,
            'metodo_pago_id': metodoPagoId,
          }));

      //print(pedidoResponse);

      if (pedidoResponse.statusCode == 200) {
        final pedidoData = jsonDecode(pedidoResponse.body);
        final ultimoPedido =
            pedidoData.last; // Obtener el último pedido (un mapa)
        final pedidoId = ultimoPedido['id_pedido'];

        for (var entry in carro.items.entries) {
          final productoId = int.parse(entry.key);
          final cantidad = entry.value;

          await http.post(Uri.parse('$apiUrl/PedidoDetalle/'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'id_pedido': pedidoId,
                'producto_id': productoId,
                'cantidad_producto': cantidad,
              }));
        }
      }
    } catch (e) {
      return -1;
    }
  }
}
