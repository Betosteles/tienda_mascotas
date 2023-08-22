import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';

import '../VariableControler/categoria_producto_controller.dart';
import '../constantes/pantalla.dart';

class CategoriaScreen extends StatelessWidget {
  final Map<String, int> categoriasProductos = {
    'Alimentos': 1,
    'Jugetes': 2,
    'Camas y Muebles': 3,
  };

  CategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categoria',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoriaCard(
                    nombre: 'Alimentos',
                    numero: categoriasProductos['Alimentos']!),
                CategoriaCard(
                    nombre: 'Jugetes', numero: categoriasProductos['Jugetes']!),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoriaCard(
                    nombre: 'Camas y Muebles',
                    numero: categoriasProductos['Camas y Muebles']!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
