import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/usuario.dart';


class PerfilCambios extends StatelessWidget {
  const PerfilCambios({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Usuario;
    print(args.nombreCompleto);

    return  Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      );
  }
}