import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tienda_mascotas/src/models/usuario.dart';


class UsuariosProvider {
  

Future<String> registrarUsuarioYCrearCarrito(
  String password,
  Usuario usuario
) async {
  try {
    // Registrar el usuario en Firebase Authentication
    UserCredential authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: usuario.correo,
      password: password,
    );

    // Obtener el UID del usuario recién registrado
    String uid = authResult.user!.uid;
  
    // Crear un documento en la colección "usuarios"
    await FirebaseFirestore.instance.collection('usuarios').doc(uid).set({
      'correo': usuario.correo,
      'nombreCompleto': usuario.nombreCompleto,
      'identidad': usuario.identidad,
      'telefono': usuario.telefono,
      'direccion': usuario.direccion,
      'referencia': usuario.referencia,
      'tipoUsuario': 'User', // Valor por defecto
    });

    // Crear la subcolección "carrito" vacía
    await FirebaseFirestore.instance.collection('usuarios').doc(uid).collection('carrito').doc('dummy').set({
      'dummyField': 'This is a placeholder and will be deleted immediately'
    });

    await FirebaseFirestore.instance.collection('usuarios').doc(uid).collection('carrito').doc('dummy').delete();
    
    return ('Usuario registrado y carrito creado exitosamente.');
  } catch (error) {
    return ('Error durante el registro: $error');
  }
}

Future<Usuario?> obtenerUsuarioPorUID(String uid) async {
  DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();

  if (userSnapshot.exists) {
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    return Usuario.fromJson(userData);
  } else {
    return null; 
  }
}

String? obtenerUIDUsuarioActivo() {
  User? user = FirebaseAuth.instance.currentUser;
  return user?.uid;
}

  

}