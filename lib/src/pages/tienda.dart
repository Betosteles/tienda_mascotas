import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';
import 'package:tienda_mascotas/src/pages/tienda_categoria_animales_page.dart';
import 'package:tienda_mascotas/src/pages/tienda_categoria_producto.dart';
import 'package:tienda_mascotas/src/pages/tienda_filtrada.dart';

import '../VariableControler/tienda_page_controller.dart';
import 'carrito.dart';

class NavTienda extends StatelessWidget {
  NavTienda({super.key});

  final tiendaController = Get.put<TiendaController>(TiendaController());

  @override
  Widget build(BuildContext context) {
    final pageController =
        PageController(initialPage: tiendaController.currentIndex);
    return MaterialApp(
        title: 'Tienda',
        routes: routes,
        home: Scaffold(
            body: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(), 
              onPageChanged: (value) async {
                
                  tiendaController.currentIndex = value;
                
              },
              children: [
                const TiendaPage(),
                Container(
                  color: Colors.blue[100],
                  child: const Center(
                    child: Text(
                      'Página 2',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const CarritoPage()
              ],
            ),
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                currentIndex: tiendaController.currentIndex,
                 
                
                onTap: (index) async {
                  tiendaController.currentIndex = index;

                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                    
                  );
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Inicio',
                    tooltip: 'Inicio',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Perfil',
                    tooltip: 'Perfil',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'carrito',
                    tooltip: 'carrito',
                  ),
                  
                ],
                
              ),
            )));
  }
}
