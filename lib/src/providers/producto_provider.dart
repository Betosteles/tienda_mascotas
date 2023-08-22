import '../models/producto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductoProvider {
  // List getUsers() {
  //   // final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  //   final users = [];
  //   final url = Uri.https('jsonplaceholder.typicode.com', 'users');

  //   http.get(url).then((value) {
  //     users.addAll(jsonDecode(value.body));
  //   }).catchError((error) {
  //     print(error);
  //   });

  //   return users;
  // }

  // Future<List> getUsers() async {
  //   // final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  //   final users = [];
  //   final url = Uri.https('jsonplaceholder.typicode.com', 'users');

  //   try {
  //     await Future.delayed(Duration(seconds: 2));

  //     final response = await http.get(url);
  //     users.addAll(jsonDecode(response.body));
  //   } catch (error) {
  //     print(error);
  //   }

  //   return users;
  // }

  Future<List<Producto>> getProducts() async {
    try {
      final url = Uri.parse('http://10.0.2.2/api/Producto/?id=0');

      final response = await http.get(url);
      print(response.body);
      return productoFromJson(response.body);
    } catch (error) {
      throw Exception('Error al obtener los productos: $error');
    }
  }

  Future<Producto> getProducto(int id) async {
    try {
      final url = Uri.parse('http://10.0.2.2/api/Producto/?id=$id');

      final response = await http.get(url);
      final productoObjeto = productoFromJson(response.body);

      return productoObjeto[0];
    } catch (error) {
      throw Exception('Error al obtener los productos: $error');
    }
  }

  Future<List<Producto>> getProductoByAC(
      {required animalId, required int categoriaID}) async {
    //AnimalId y CategoriaID
    try {
      final url = Uri.parse(
          'http://10.0.2.2/api/Producto/?idA=$animalId&idC=$categoriaID');

      final response = await http.get(url);
      return productoFromJson(response.body);
    } catch (error) {
      throw Exception('Error al obtener los productos: $error');
    }
  }
}
