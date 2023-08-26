import 'package:flutter/material.dart';
// import 'package:tienda_mascotas/src/constantes/routes.dart';
// import 'package:tienda_mascotas/src/pages/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';
import 'package:tienda_mascotas/src/pages/login.dart';
import 'package:tienda_mascotas/src/providers/carrito_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final carritoProvider = CarritoService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home:   LoginPage(),
      initialRoute: MyRoutes.login.name,
      routes: routes,
    );
    
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Firebase Auth Example',
//       home: AuthenticationScreen(),
//     );
//   }
// }






}