import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/metodo_pago_model.dart';

class MetodoPagoProvider {
  final url = Uri.parse('http://140.84.182.78/api/MetodoPago/');

  Future<List<MetodoPago>> obtenerMetodosPago() async {
    final response = await http.get(Uri.parse('$url?id=0'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => MetodoPago.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener los métodos de pago');
    }
  }

  Future<MetodoPago> obtenerMetodoPagoPorId(int metodoPagoId) async {
    final response = await http.get(Uri.parse('$url?id=$metodoPagoId'));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return MetodoPago.fromJson(data);
    } else {
      throw Exception('Error al obtener el método de pago');
    }
  }
}
