import 'dart:convert';



List<PedidoDetalle> pedidoDetalleFromJson(String str) =>
    List<PedidoDetalle>.from(json.decode(str).map((x) => PedidoDetalle.fromJson(x)));

String pedidoDetalleToJson(List<PedidoDetalle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PedidoDetalle {
  int idPedido;
  int productoId;
  int cantidadProducto;

  PedidoDetalle({
    required this.idPedido,
    required this.productoId,
    required this.cantidadProducto,
  });

  factory PedidoDetalle.fromJson(Map<String, dynamic> json) {
    return PedidoDetalle(
      idPedido: json['id_pedido'],
      productoId: json['producto_id'],
      cantidadProducto: json['cantidad_producto'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id_pedido': idPedido,
      'producto_id': productoId,
      'cantidad_producto': cantidadProducto,
    };
  }
}