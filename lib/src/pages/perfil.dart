import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';
import 'package:tienda_mascotas/src/models/usuario.dart';
import 'package:tienda_mascotas/src/providers/usuarios_provider.dart';

import '../widgets/menu_perfil.dart';

class PaginaPerfil extends StatelessWidget {
  const PaginaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioProvide = UsuariosProvider();

    return 
      
       FutureBuilder<Usuario?>(
        future: usuarioProvide
            .obtenerUsuarioActual(), // Llama a la función para obtener el usuario
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtiene el usuario
          } else if (snapshot.hasError) {
            return const Text('Error al obtener el usuario');
          } else {
            Usuario? usuario = snapshot.data;
            if (usuario != null) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Perfil",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  backgroundColor: Colors.green[900],
                ),
                body: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                                child: Text(
                              usuario.nombreCompleto[0],
                              style: const TextStyle(fontSize: 60),
                            ))),
                        const SizedBox(height: 10),
                        Text(
                          usuario.nombreCompleto,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          usuario.correo,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                MyRoutes.perfilCambios.name,
                                arguments: usuario,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide.none,
                            ),
                            child: const Text(
                              "Editar Perfil",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(height: 10),
                        WidgetMenuPerfil(
                          title: "Pedidos Pendientes",
                          icon: Icons.local_shipping,
                          onPress: () {
    
                            Navigator.pushNamed(context, MyRoutes.pedidosPendientes.name);
    
                          },
                        ),
                        WidgetMenuPerfil(
                            title: "Pedidos Pasados",
                            icon: Icons.inventory,
                            onPress: () {
    
                              Navigator.pushNamed(context, MyRoutes.pedidosPasados.name);
    
                            }),
                        const Divider(
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        Container(
                            alignment: Alignment.bottomCenter,
                            child: WidgetMenuPerfil(
                                title: "Cerrar Sesion",
                                icon: Icons.logout,
                                textColor: Colors.red,
                                endIcon: false,
                                onPress: () {
                                  usuarioProvide.cerrarSesion();
                                  Navigator.pushNamed(
                                      context, MyRoutes.login.name);
                                  //navegacion al login
                                }))
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Text('Usuario no encontrado');
            }
          }
        });
      
    
  }
}