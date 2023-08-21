
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';

import '../models/carrito_model.dart';
import '../providers/carrito_provider.dart';
import '../widgets/dropdown_button_metodo_pago.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  User? _user; // Variable para almacenar la información del usuario
  final ValueNotifier<String?> valorSeleccionadoController = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    // Suscribe para escuchar los cambios en el estado de autenticación
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user; // Actualiza la variable del usuario
      });
    });
  }

  final carrito = CarritoService();
  


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Auth Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_user == null) const Text('No se ha iniciado sesión'),
              if (_user != null) Text('Usuario autenticado: ${_user!.email}'),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Correo electrónico',
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;
    
                  _auth
                      .signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  )
                      .then((_) {
                    navigateToAuthenticationScreen(context);
                  }).catchError((error) {
                    print('Error: $error');
                  });
                },
                child: const Text('Iniciar sesión con correo y contraseña'),
              ),
              ElevatedButton(
                onPressed: () {
                  _auth.signOut().then((value) {
                    navigateToAuthenticationScreen(context);
                  }).catchError((error) {
                    print(
                        '------------------------*******************************------------------Error: $error');
                  });
                },
                child: const Text('Cerrar sesión'),
              ),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, MyRoutes.tiendaNav.name);
              }
              , child: const Text("test")
              ),
    
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, MyRoutes.tienda.name);
              }
              , child: const Text("Go Store")
              ),
              ElevatedButton(onPressed: () async {
                Carrito carro = await carrito.obtenerCarrito();

                print(carro.items);
    
                // carro.items.forEach((productId, quantity) {
                // print('ID del producto: $productId, Cantidad: $quantity');
                //   });
                Navigator.pushNamed(context, MyRoutes.carrito.name);
              }
              , child: const Text("Carrito")
              ),
              MetodoPagoDropdown(valorSeleccionadoController:valorSeleccionadoController),

    
            ],
          ),
        ),
      ),
    );
  }
}

void navigateToAuthenticationScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const AuthenticationScreen(),
    ),
  );
}

Future<User?> obtenerUsuarioActivo() async {
  try {
    // Obtener el usuario autenticado actualmente
    User? usuario = FirebaseAuth.instance.currentUser;
    
    return usuario;
  } catch (error) {
    print('Error al obtener el usuario activo: $error');
    return null;
  }
}