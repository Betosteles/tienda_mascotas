import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Login({super.key});

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Enviar datos al servidor y manejar la respuesta aquí
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio de Sesión')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu nombre de usuario';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Nombre de Usuario'),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu contraseña';
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}