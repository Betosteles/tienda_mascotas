import 'package:http/http.dart' as http;
import 'package:tienda_mascotas/src/models/pedido_estado.dart';

class PedidoEstadoProvide {
  Future<List<PedidoEstado>> getPedidoEstado(int pedidoId) async {
    try {
      final url = Uri.parse('http://10.0.2.2/api/PedidoEstado/?id=$pedidoId');
      final response = await http.get(url);
      return pedidoEstadoFromJson(response.body);
    } catch (error) {
      throw Exception('$error');
    }
  }
}
