import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/constantes/tema.dart';

import '../widgets/tienda_animal_card.dart';

class AnimalScreen extends StatelessWidget {
  final Map<String, int> categoriasAnimales = {
    'Perro': 1,
    'Gato': 2,
    'Loro': 3,
    'Pez': 4,
    'Hamster': 5,
    'Cerdito': 7,
  };

  AnimalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarStyle('Animales'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimalCard(
                    nombre: 'Perro', numero: categoriasAnimales['Perro']!),
                AnimalCard(nombre: 'Gato', numero: categoriasAnimales['Gato']!),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimalCard(nombre: 'Loro', numero: categoriasAnimales['Loro']!),
                AnimalCard(nombre: 'Pez', numero: categoriasAnimales['Pez']!),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimalCard(
                    nombre: 'Hamster', numero: categoriasAnimales['Hamster']!),
                AnimalCard(
                    nombre: 'Cerdito', numero: categoriasAnimales['Cerdito']!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
