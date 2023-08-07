
import '../pages/admin.dart';
import '../pages/login.dart';
import '../pages/tienda.dart';

enum MyRoutes {
  login,
  admin,
  tienda,
  
}

final routes = {
  MyRoutes.login.name: (context) => const Login(),
  MyRoutes.admin.name: (context) => const AdminPage(),
  MyRoutes.tienda.name: (context) => const TiendaPage(),
};