import 'package:http/http.dart' as http;
import 'package:tienda_mascotas/src/models/pedido_estado.dart';
import 'package:tienda_mascotas/src/widgets/snackbar_helper.dart';

final estadoVacio = PedidoEstado(estadoId: 2, idPedido: 0);

class PedidoEstadoProvide {
  Future<PedidoEstado> getPedidoEstado(int pedidoId) async {
    try {
      final url =
          Uri.parse('http://140.84.182.78/api/PedidoEstado/?id=$pedidoId');
      final response = await http.get(url);
      final body = pedidoEstadoFromJson(response.body);

      if (body.isEmpty) {
        return estadoVacio;
      } else {
        return pedidoEstadoFromJson(response.body)[0];
      }
    } catch (error) {
      throw Exception('Error PedidoEstadoProvide $error');
    }
  }

  Future<void> actualizarEstadoPedido(
      int pedidoId, int nuevoEstadoId, contexto) async {
    try {
      final url = Uri.parse('http://140.84.182.78/api/PedidoEstado/');
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: '{"pedido_id": $pedidoId, "estado_id": $nuevoEstadoId}',
      );

      if (response.statusCode != 200) {
        throw Exception('Error al actualizar el estado del pedido');
      }

      if (response.statusCode == 200) {
        SnackBarHelper.showSnackBar(
            contexto, "Modificado Con Exito!", SnackBarType.info);
      }
    } catch (error) {
      throw Exception('Error PedidoEstadoProvide $error');
    }
  }
}
