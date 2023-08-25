import 'dart:convert';



List<PedidoEstado> pedidoEstadoFromJson(String str) =>
    List<PedidoEstado>.from(json.decode(str).map((x) => PedidoEstado.fromJson(x)));

String pedidoEstadoToJson(List<PedidoEstado> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PedidoEstado {
  int idPedido;
  int estadoId;


  PedidoEstado({
    required this.idPedido,
    required this.estadoId,
 
  });

  factory PedidoEstado.fromJson(Map<String, dynamic> json) {
    return PedidoEstado(
      idPedido: json['pedido_id'],
      estadoId: json['estado_id'],
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pedido_id': idPedido,
      'estado_id': estadoId,
     
    };
  }
}