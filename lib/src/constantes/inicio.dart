import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';
import '../pages/admin.dart';
import '../pages/login.dart';
import '../pages/tienda.dart';

MaterialApp getInicioRuta(String inicio) {
  if (inicio == 'User') {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: NavTienda(),
      initialRoute: MyRoutes.tiendaNav.name,
      routes: routes,
    );
  }
  if (inicio == "Admin") {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const VerPedidosPage(),
      initialRoute: MyRoutes.admin.name,
      routes: routes,
    );
  }
  return MaterialApp(
          theme: ThemeData(useMaterial3: true),
          home: LoginPage(),
          initialRoute: MyRoutes.login.name,
          routes: routes,
        );
}


MaterialApp getInicioRutaNull(){
   return MaterialApp(
          theme: ThemeData(useMaterial3: true),
          home: LoginPage(),
          initialRoute: MyRoutes.login.name,
          routes: routes,
        );
}