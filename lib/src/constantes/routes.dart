


import 'package:tienda_mascotas/src/pages/admin.dart';
import 'package:tienda_mascotas/src/pages/detalle_producto_page.dart';
import 'package:tienda_mascotas/src/pages/login.dart';
import 'package:tienda_mascotas/src/pages/tienda_filtrada.dart';

import '../pages/administrar_pedidos.dart';
import '../pages/carrito.dart';
import '../pages/perfil.dart';
import '../pages/perfil_cambios.dart';
import '../pages/tienda.dart';
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
  animal,
  categoria,
  tiendaNav,
  adminPedidos,
  perfil,
  perfilCambios,

  
}

final routes = {
  MyRoutes.login.name: (context) => LoginPage(),
  MyRoutes.admin.name: (context) => const VerPedidosPage(),
  MyRoutes.tienda.name: (context) => const TiendaPage(),
  MyRoutes.detalleProducto.name: (context) =>  DetalleProducto(),
  MyRoutes.test.name: (context) =>  const AuthenticationScreen(),
  MyRoutes.carrito.name: (context) =>  const CarritoPage(),
  MyRoutes.animal.name: (context) => AnimalScreen(),
  MyRoutes.categoria.name: (context) => CategoriaScreen(),
  MyRoutes.tiendaNav.name: (context) => NavTienda(),
  MyRoutes.adminPedidos.name: (context) => const AdministrarPedidosPage(),
  MyRoutes.perfil.name: (context) => const PaginaPerfil(),
  MyRoutes.perfilCambios.name: (context) => const PerfilCambios(),
  
};