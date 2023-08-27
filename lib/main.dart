import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tienda_mascotas/src/constantes/inicio.dart';
import 'package:tienda_mascotas/src/providers/auth_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getInicio(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Mostrar un indicador de carga mientras esperamos
          } else if (snapshot.hasData) {
            final inicio = snapshot.data!;
            return getInicioRuta(inicio);
          }
          return getInicioRutaNull();
        });
  }
}
