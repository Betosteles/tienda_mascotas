import 'dart:convert';

List<Carrito> carritoFromJson(String str) =>
    List<Carrito>.from(json.decode(str).map((x) => Carrito.fromJson(x)));

String carritoToJson(List<Carrito> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carrito {
  Map<String, dynamic> items;

  Carrito({
    required this.items,
  });

  factory Carrito.fromJson(Map<String, dynamic> json) {
    final items = Map<String, dynamic>.from(json.map(
      (key, value) => MapEntry(int.parse(key), value as int),
    ));
    return Carrito(items: items);
  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>.from(items.map(
      (key, value) => MapEntry(key.toString(), value),
    ));
  }
}
