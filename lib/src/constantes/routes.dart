


import 'package:tienda_mascotas/src/pages/admin.dart';
import 'package:tienda_mascotas/src/pages/detalle_producto_page.dart';
import 'package:tienda_mascotas/src/pages/login.dart';
import 'package:tienda_mascotas/src/pages/tienda_filtrada.dart';

import '../pages/carrito.dart';
import '../pages/tienda_categoria_animales_page.dart';
import '../pages/tienda_categoria_producto.dart';
import '../test/auth_test.dart';

enum MyRoutes {
  login,
  admin,
  tienda, 
  detalleProducto,
  test,
  carrito,
  test2,
  test3,
  
}

final routes = {
  MyRoutes.login.name: (context) => Login(),
  MyRoutes.admin.name: (context) => const AdminPage(),
  MyRoutes.tienda.name: (context) => const TiendaPage(),
  MyRoutes.detalleProducto.name: (context) =>  DetalleProducto(),
  MyRoutes.test.name: (context) =>  const AuthenticationScreen(),
  MyRoutes.carrito.name: (context) =>  const CarritoPage(),
  MyRoutes.test2.name: (context) => AnimalScreen(),
  MyRoutes.test3.name: (context) => CategoriaScreen(),
  
};