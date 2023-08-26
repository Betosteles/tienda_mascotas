import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../VariableControler/categoria_producto_controller.dart';
import '../constantes/pantalla.dart';
import '../constantes/routes.dart';

class CategoriaCard extends StatelessWidget {
  final String nombre;
  final int numero;

  const CategoriaCard({super.key, required this.nombre, required this.numero});

  @override
  Widget build(BuildContext context) {
    double halfScreenWidth = calculateHalfScreenWidth(context);

    final categoriaProducto =
        Get.put<CategoriaProductosController>(CategoriaProductosController());

    return GestureDetector(
      onTap: () {
        //print('Número del animal: ${categoriaProducto.currentProductosCategory}');
        categoriaProducto.currentProductosCategory = numero;
        Navigator.pushNamed(context, MyRoutes.tiendaNav.name);
        //print('Número del animal: ${categoriaProducto.currentProductosCategory}');
      },
      child: SizedBox(
        width: halfScreenWidth, // Expand to the available width
        height: 200, // Set a specific height
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('images/${nombre.toLowerCase()}.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    nombre,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.black, // Color del contorno
                    ),
                  ),
                  Text(
                    nombre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Color del texto principal
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
