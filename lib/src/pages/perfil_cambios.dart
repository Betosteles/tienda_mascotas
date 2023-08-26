import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';
import 'package:tienda_mascotas/src/models/usuario.dart';
import 'package:tienda_mascotas/src/providers/usuarios_provider.dart';
import 'package:tienda_mascotas/src/widgets/snackbar_helper.dart';
import '../constantes/tema.dart';

class PerfilCambios extends StatelessWidget {
  const PerfilCambios({super.key});

  @override
  Widget build(BuildContext context) {
    Usuario args = ModalRoute.of(context)!.settings.arguments as Usuario;
    final usuarioProvide = UsuariosProvider();

    // Controladores para los TextFields
    TextEditingController nombreController =
        TextEditingController(text: args.nombreCompleto);
    TextEditingController identidadController =
        TextEditingController(text: args.identidad);
    TextEditingController numeroController =
        TextEditingController(text: args.telefono);
    TextEditingController direccionController =
        TextEditingController(text: args.direccion);
    TextEditingController referenciaController =
        TextEditingController(text: args.referencia);

    return Scaffold(
      appBar: getAppBarStyle('Editar Usuario'),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              keyboardType: TextInputType.name,
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
              ),
              onChanged: (value) {
                args.nombreCompleto = nombreController.text;
              },
            ),
            // Resto de los TextFields
            TextField(
              keyboardType: TextInputType.number,
              controller: identidadController,
              decoration: const InputDecoration(
                labelText: 'Identidad',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: numeroController,
              decoration: const InputDecoration(
                labelText: 'Número',
              ),
            ),
            TextField(
              keyboardType: TextInputType.streetAddress,
              controller: direccionController,
              decoration: const InputDecoration(
                labelText: 'Dirección',
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              controller: referenciaController,
              decoration: const InputDecoration(
                labelText: 'Referencia',
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await usuarioProvide.modificarUsuario(args).then((value) {
                      if (value == "Exito") {
                        SnackBarHelper.showSnackBar(context,
                            "Cambios Realizados con Exito", SnackBarType.info);
                        Navigator.pushNamed(context, MyRoutes.tiendaNav.name);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
