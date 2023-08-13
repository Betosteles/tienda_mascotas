


import 'package:tienda_mascotas/src/pages/admin.dart';
import 'package:tienda_mascotas/src/pages/detalle_producto_page.dart';
import 'package:tienda_mascotas/src/pages/login.dart';
import 'package:tienda_mascotas/src/pages/tienda.dart';

import '../test/auth_test.dart';

enum MyRoutes {
  login,
  admin,
  tienda, 
  detalleProducto,
  test,
  
}

final routes = {
  MyRoutes.login.name: (context) => Login(),
  MyRoutes.admin.name: (context) => const AdminPage(),
  MyRoutes.tienda.name: (context) => const TiendaPage(),
  MyRoutes.detalleProducto.name: (context) =>  DetalleProducto(),
  MyRoutes.detalleProducto.name: (context) =>  const AuthenticationScreen(),
  
};