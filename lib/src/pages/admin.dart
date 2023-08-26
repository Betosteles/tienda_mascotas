import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/providers/pedido_provider.dart';

import '../constantes/routes.dart';
import '../models/pedido.dart';
import '../providers/usuarios_provider.dart';
import '../widgets/list_view_admin.dart';

class VerPedidosPage extends StatelessWidget {
  const VerPedidosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pedidoProvider = PedidoProvider();
    final usuarioProvide = UsuariosProvider();
    return MaterialApp(
      title: 'Admin',
      routes: routes,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Administrar Pedidos'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                usuarioProvide.cerrarSesion();
                Navigator.pushNamed(context, MyRoutes.login.name);
              },
            ),
          ],
        ),
        body: FutureBuilder<List<Pedido>>(
          future: pedidoProvider.getPedidosDesc(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
            } else if (snapshot.hasError) {
              return const Text(
                  'Error al cargar los pedidos'); // Muestra un mensaje de error si hay un problema
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text(
                  'No hay pedidos disponibles'); // Muestra un mensaje si no hay datos disponibles
            } else {
              return AdminListView(snapshot: snapshot);
            }
          },
        ),
      ),
    );
  }
}
