import 'dart:convert';


List<Pedido> pedidoFromJson(String str) =>
    List<Pedido>.from(json.decode(str).map((x) => Pedido.fromJson(x)));

String pedidoToJson(List<Pedido> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
      
class Pedido {
  int idPedido;
  String fechaPedido;
  String clienteId;
  int metodoPagoId;

  Pedido({
    required this.idPedido,
    required this.fechaPedido,
    required this.clienteId,
    required this.metodoPagoId,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      idPedido: json['id_pedido'],
      fechaPedido: json['fecha_pedido'],
      clienteId: json['cliente_id'],
      metodoPagoId: json['metodo_pago_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pedido': idPedido,
      'fecha_pedido': fechaPedido,
      'cliente_id': clienteId,
      'metodo_pago_id': metodoPagoId,
    };
  }
}



