import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; 
import 'package:tienda_mascotas/src/constantes/routes.dart';


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
        primarySwatch: Colors.green, // Cambia el color temático principal
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
  String errorMessage = ''; // Agrega esta variable de estado

  @override
  Widget build(BuildContext context) {
    
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
                  Navigator.pushNamed(context, MyRoutes.tiendaNav.name);
                }
              } catch (error) {
                print('Error de inicio de sesión: $error');
                if (error is FirebaseAuthException &&
                    error.code == 'wrong-password') {
                  setState(() {
                    errorMessage = 'Contraseña incorrecta';
                  });
                }
              }
            },
            child: const Text('Ingresar'),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: () {
             
            },
            child: const Text('Registrarme'),
          ),
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}