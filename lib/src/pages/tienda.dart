import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';
import 'package:tienda_mascotas/src/pages/perfil.dart';
import 'package:tienda_mascotas/src/pages/tienda_filtrada.dart';

import '../VariableControler/tienda_page_controller.dart';
import '../VariableControler/total_amount_cart.dart';
import '../providers/carrito_provider.dart';
import 'carrito.dart';

class NavTienda extends StatelessWidget {
  NavTienda({super.key});

  final tiendaController = Get.put<TiendaController>(TiendaController());
  final totalCarrito =
      Get.put<TotalAmountProductController>(TotalAmountProductController());
  final carrito = CarritoService();

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
              children: const [TiendaPage(), PaginaPerfil(), CarritoPage()],
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
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Inicio',
                    tooltip: 'Inicio',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Perfil',
                    tooltip: 'Perfil',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.shopping_cart),
                  //   label: 'carrito',
                  //   tooltip: 'carrito',
                  // ),

                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        const Icon(Icons.shopping_cart),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              totalCarrito.currentTotalAmount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    label: 'Carrito',
                    tooltip: 'Carrito',
                  ),
                ],
              ),
            )));
  }
}
