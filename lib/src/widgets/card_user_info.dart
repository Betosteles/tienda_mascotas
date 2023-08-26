import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/usuario.dart';
import 'package:tienda_mascotas/src/providers/usuarios_provider.dart';

class UserInfoCard extends StatelessWidget {
  final String uid;

  const UserInfoCard({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final usuariosProvider = UsuariosProvider();

    return FutureBuilder<Usuario?>(
      future: usuariosProvider.obtenerUsuarioPorUID(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No se encontró información del usuario.');
        } else {
          Usuario usuario = snapshot.data!;

          return SizedBox(
            width: double.infinity, // Ocupa todo el ancho disponible
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Información del Usuario',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Correo: ${usuario.correo}'),
                      Text('Nombre Completo: ${usuario.nombreCompleto}'),
                      Text('Identidad: ${usuario.identidad}'),
                      Text('Teléfono: ${usuario.telefono}'),
                      Text('Dirección: ${usuario.direccion}'),
                      Text('Referencia: ${usuario.referencia}'),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
