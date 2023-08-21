import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../VariableControler/categoria_animales_controller.dart';
import '../constantes/pantalla.dart';

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
      appBar: AppBar(
        title: const Text('Animales'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimalCard(nombre: 'Perro', numero: categoriasAnimales['Perro']!),
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
                AnimalCard(nombre: 'Hamster', numero: categoriasAnimales['Hamster']!),
                AnimalCard(nombre: 'Cerdito', numero: categoriasAnimales['Cerdito']!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalCard extends StatelessWidget {
  final String nombre;
  final int numero;

  const AnimalCard({super.key, required this.nombre, required this.numero});
  

  @override
  Widget build(BuildContext context) {
    double halfScreenWidth = calculateHalfScreenWidth(context);
    final categoriaAnimales = Get.put<CategoriaAnimalesController>(CategoriaAnimalesController());

    return GestureDetector(
      onTap: () {
        //print('Número del animal: ${categoriaAnimales.currentAnimalesCategory}');
        categoriaAnimales.currentAnimalesCategory=numero;
        //print('Número del animal: ${categoriaAnimales.currentAnimalesCategory}');

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
