import 'dart:convert';

List<MetodoPago> metodoPagoFromJson(String str) =>
    List<MetodoPago>.from(json.decode(str).map((x) => MetodoPago.fromJson(x)));

String productoToJson(List<MetodoPago> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MetodoPago {
  // ignore: non_constant_identifier_names
  final int metodo_pago_id;
  final String nombre;

  MetodoPago({
    // ignore: non_constant_identifier_names
    required this.metodo_pago_id,
    required this.nombre,
  });

  factory MetodoPago.fromJson(Map<String, dynamic> json) => MetodoPago(
        metodo_pago_id: json["metodo_pago_id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "metodo_pago_id": metodo_pago_id,
        "nombre": nombre,
      };
}
