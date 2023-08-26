import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/usuario.dart';
import 'package:tienda_mascotas/src/providers/usuarios_provider.dart'; // Asegúrate de importar correctamente
import 'package:tienda_mascotas/src/constantes/routes.dart';

import '../widgets/snackbar_helper.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _identidadController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _referenciaController = TextEditingController();
  final UsuariosProvider _usuariosProvider = UsuariosProvider();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // Puedes validar y guardar los campos aquí
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo electrónico'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre Completo'),
              ),
              TextFormField(
                controller: _identidadController,
                decoration:
                    const InputDecoration(labelText: 'Número de Identidad'),
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
              ),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(labelText: 'Dirección'),
              ),
              TextFormField(
                controller: _referenciaController,
                decoration: const InputDecoration(labelText: 'Referencia'),
              ),
              ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  String nombre = _nombreController.text;
                  String identidad = _identidadController.text;
                  String telefono = _telefonoController.text;
                  String direccion = _direccionController.text;
                  String referencia = _referenciaController.text;

                  // Validar campos
                  if (!_isValidEmail(email) ||
                      password.length < 6 ||
                      nombre.isEmpty ||
                      identidad.isEmpty ||
                      telefono.isEmpty ||
                      direccion.isEmpty ||
                      referencia.isEmpty) {
                    // Mostrar mensaje de error
                    SnackBarHelper.showSnackBar(context, 'Por favor, completa todos los campos correctamente.',SnackBarType.error);
                   
                        // content: Text(
                        //     'Por favor, completa todos los campos correctamente.'),
                        // duration: Duration(seconds: 2),
                    
                    return; // Salir de la función si los campos no son válidos
                  }

                  bool emailExists =
                      await _usuariosProvider.verificarCorreoExistente(email);

                  if (emailExists) {
                    // Mostrar mensaje de correo existente
                    // ignore: use_build_context_synchronously
                    SnackBarHelper.showSnackBar(
                      context,
                      'El correo electrónico ya está registrado.',
                      SnackBarType.error,
                    );
                  } else {
                    String result =
                        await _usuariosProvider.registrarUsuarioYCrearCarrito(
                      password,
                      Usuario(
                        correo: email,
                        nombreCompleto: nombre,
                        identidad: identidad,
                        telefono: telefono,
                        direccion: direccion,
                        referencia: referencia,
                        tipoUsuario: '',
                      ),
                    );
                    SnackBarHelper.showSnackBar( context, 'Se registró con éxito. ¡Bienvenido!', SnackBarType.info);
                   
                      
                    

// Redirigir a la página de inicio de sesión
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.pushNamed(context, MyRoutes.login.name);
                    });
                  }
                },
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool _isValidEmail(String email) {
  return email.contains('@');
}