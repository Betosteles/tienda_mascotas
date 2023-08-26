import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/constantes/tema.dart';

import '../widgets/tienda_categoria_card.dart';

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
      appBar: getAppBarStyle('Categoria'),
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
