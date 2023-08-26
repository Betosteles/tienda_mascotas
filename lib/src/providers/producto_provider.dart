import '../models/producto.dart';
import 'package:http/http.dart' as http;

class ProductoProvider {
  Future<List<Producto>> getProducts() async {
    try {
      final url = Uri.parse('http://140.84.182.78/api/Producto/?id=0');

      final response = await http.get(url);
      return productoFromJson(response.body);
    } catch (error) {
      throw Exception('Error al obtener los productos: $error');
    }
  }

  Future<Producto> getProducto(int id) async {
    try {
      final url = Uri.parse('http://140.84.182.78/api/Producto/?id=$id');

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
          'http://140.84.182.78/api/Producto/?idA=$animalId&idC=$categoriaID');

      final response = await http.get(url);
      return productoFromJson(response.body);
    } catch (error) {
      throw Exception('Error al obtener los productos: $error');
    }
  }
}
