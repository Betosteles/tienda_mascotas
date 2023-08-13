import 'dart:convert';

List<Producto> productoFromJson(String str) =>
    List<Producto>.from(json.decode(str).map((x) => Producto.fromJson(x)));

String productoToJson(List<Producto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Producto {
  final int productoId; // Cambio de "id" a "productoId"
  final int categoriaAnimalId;
  final int categoriaProductoId;
  final String nombre;
  final String marca;
  final String descripcion;
  final double precio;
  final int stock;
  final String codigoBarra;
  final String imagenes;
  final int garantia; 

  Producto({
    required this.productoId,
    required this.categoriaAnimalId,
    required this.categoriaProductoId,
    required this.nombre,
    required this.marca,
    required this.descripcion,
    required this.precio,
    required this.stock,
    required this.codigoBarra,
    required this.imagenes,
    required this.garantia,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        productoId: json["producto_id"], 
        categoriaAnimalId: json["categoria_animal_id"],
        categoriaProductoId: json["categoria_producto_id"],
        nombre: json["nombre"],
        marca: json["marca"],
        descripcion: json["descripcion"],
        precio: json["precio"].toDouble(),
        stock: json["stock"],
        codigoBarra: json["codigo_barra"],
        imagenes: "http://10.0.2.2/tienda/img/${json["imagenes"]}",
        garantia: json["garantia"],
      );

  Map<String, dynamic> toJson() => {
        "producto_id": productoId,
        "categoria_animal_id": categoriaAnimalId,
        "categoria_producto_id": categoriaProductoId,
        "nombre": nombre,
        "marca": marca,
        "descripcion": descripcion,
        "precio": precio,
        "stock": stock,
        "codigo_barra": codigoBarra,
        "imagenes": imagenes,
        "garantia": garantia,
      };
}

