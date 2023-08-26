import 'package:http/http.dart' as http;
import 'package:tienda_mascotas/src/models/pedido_detalle.dart';
import 'package:tienda_mascotas/src/providers/producto_provider.dart';

import '../models/producto.dart';

class PedidoDetalleProvider {
  Future<List<PedidoDetalle>> getPedidoDetalle(int idPedido) async {
    try {
      final url =
          Uri.parse('http://140.84.182.78/api/PedidoDetalle/?id=$idPedido');
      final response = await http.get(url);
      return pedidoDetalleFromJson(response.body);
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<double> getTotalPedido(int idPedido) async {
    try {
      final productoProvider = ProductoProvider();
      Producto producto;

      double total = 0.0;

      List<PedidoDetalle> pedido = await getPedidoDetalle(idPedido);

      for (var detalle in pedido) {
        producto = await productoProvider.getProducto(detalle.productoId);

        total += producto.precio * detalle.cantidadProducto;

        //print('Detalle ${detalle.idPedido} - ${detalle.productoId} - ${detalle.cantidadProducto}');
      }

      return total;
    } catch (error) {
      throw Exception('$error');
    }
  }
}
