import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../models/pedido.dart';

class PedidoProvider {
  User? user = FirebaseAuth.instance.currentUser;

  Future<List<Pedido>> getPedido() async {
    try {
      if (user != null) {
        final url = Uri.parse(
            'http://140.84.182.78/api/Pedido/?cliente_id=${user!.uid}');
        final response = await http.get(url);
        return pedidoFromJson(response.body);
      } else {
        final url = Uri.parse('http://localhost/api/Pedido/?cliente_id=0');
        final response = await http.get(url);
        return pedidoFromJson(response.body);
      }
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<List<Pedido>> getPedidosDesc() async {
    try {
      final url = Uri.parse("http://140.84.182.78/api/Pedido/?id=-1");
      final response = await http.get(url);
      return pedidoFromJson(response.body);
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<int> totalPedidos() async {
    try {
      final url = Uri.parse("http://140.84.182.78/api/Pedido/?total");
      final response = await http.get(url);
      return json.decode(response.body)['total'];
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<List<Pedido>> getPedidoAllDescLimitAndOffset(
      int limit, int offset) async {
    try {
      final url = Uri.parse(
          "http://140.84.182.78/api/Pedido/?limit=$limit&offset=$offset");
      final response = await http.get(url);
      return pedidoFromJson(response.body);
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<List<Pedido>> getPedidosPorCliente() async {
    try {
      final url =
          Uri.parse('http://140.84.182.78/api/Pedido/?cliente_id=${user?.uid}');
      final response = await http.get(url);
      return pedidoFromJson(response.body);
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<List<Pedido>> getPedidosPorCliente2() async {
    try {
      final url = Uri.parse(
          'http://140.84.182.78/api/Pedido/?cliente_id=${user?.uid}&completado');
      final response = await http.get(url);
      return pedidoFromJson(response.body);
    } catch (error) {
      throw Exception('$error');
    }
  }
}
