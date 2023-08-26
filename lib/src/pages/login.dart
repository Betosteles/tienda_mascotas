import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';
import 'package:tienda_mascotas/src/widgets/snackbar_helper.dart';

import '../providers/auth_helper.dart';

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Vet Shop')),
        body: Center(
          child: LoginForm(
            auth: _auth,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final FirebaseAuth auth;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    Key? key,
    required this.auth,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    AuthHelper.checkLoggedInUser(context, _auth);

    Map<String, String> errorCodeMessages = {
      'invalid-email': 'Correo electrónico inválido',
      'user-disabled': 'Usuario deshabilitado',
      'user-not-found': 'Usuario no encontrado',
      'wrong-password': 'Contraseña incorrecta',
      'channel-error': 'Ingrese los datos'
    };

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Iniciar Sesión',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: widget.emailController,
            decoration: const InputDecoration(labelText: 'Correo Electrónico'),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: widget.passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              final email = widget.emailController.text;
              final password = widget.passwordController.text;

              try {
                final userCredential =
                    await widget.auth.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                final user = userCredential.user;
                if (user != null) {
                  // Obtener el campo 'tipoUsuario' del usuario desde Firestore
                  String uid = user.uid;
                  DocumentSnapshot userSnapshot = await FirebaseFirestore
                      .instance
                      .collection('usuarios')
                      .doc(uid)
                      .get();

                  if (userSnapshot.exists) {
                    Map<String, dynamic> userData =
                        userSnapshot.data() as Map<String, dynamic>;
                    String userType = userData['tipoUsuario'];

                    if (userType == 'User') {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, MyRoutes.tiendaNav.name);
                    } else if (userType == 'Admin') {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, MyRoutes.admin.name);
                    } else {
                      // Si el tipo de usuario no es reconocido, manejarlo de acuerdo a tus necesidades
                    }
                  }
                }
              } catch (error) {
                if (error is FirebaseAuthException) {
                  String errorCode = error.code;
                  String errorMessage =
                      errorCodeMessages[errorCode] ?? 'Error desconocido';
                  setState(() {
                    this.errorMessage = errorMessage;
                  });
                  SnackBarHelper.showSnackBar(
                      context, errorMessage, SnackBarType.error);
                }
              }
            },
            child: const Text('Ingresar'),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.registrarUser.name);
            },
            child: const Text('Registrarme'),
          ),
        ],
      ),
    );
  }
}
