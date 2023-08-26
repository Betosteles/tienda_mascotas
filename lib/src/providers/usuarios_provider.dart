import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tienda_mascotas/src/models/usuario.dart';

class UsuariosProvider {
  Future<bool> verificarCorreoExistente(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('correo', isEqualTo: email)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<String> registrarUsuarioYCrearCarrito(
      String password, Usuario usuario) async {
    try {
      // Registrar el usuario en Firebase Authentication
      UserCredential authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(uid)
          .collection('carrito')
          .doc('dummy')
          .set({
        'dummyField': 'This is a placeholder and will be deleted immediately'
      });

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(uid)
          .collection('carrito')
          .doc('dummy')
          .delete();

      return ('Exito');
    } catch (error) {
      return ('Error durante el registro: $error');
    }
  }

  Future<Usuario?> obtenerUsuarioPorUID(String uid) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      return Usuario.fromJson(userData);
    } else {
      return null;
    }
  }

  String? obtenerUIDUsuarioActivo() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<Usuario?> obtenerUsuarioActual() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        return Usuario.fromJson(userData);
      }
    } else {
      return null;
    }
    return null;
  }

  Future<String> cambiarContrasena(
      String currentPassword, String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Reautenticar al usuario con su contraseña actual antes de cambiar la contraseña
      AuthCredential credentials = EmailAuthProvider.credential(
        email: user?.email ?? '',
        password: currentPassword,
      );
      await user?.reauthenticateWithCredential(credentials);

      // Cambiar la contraseña
      await user?.updatePassword(newPassword);

      return ('Contraseña cambiada exitosamente.');
    } catch (error) {
      return ('Error al cambiar la contraseña: $error');
    }
  }

  Future<String> modificarUsuario(Usuario nuevoUsuario) async {
    try {
      String uid = obtenerUIDUsuarioActivo() ?? '';

      await FirebaseFirestore.instance.collection('usuarios').doc(uid).update({
        'correo': nuevoUsuario.correo,
        'nombreCompleto': nuevoUsuario.nombreCompleto,
        'identidad': nuevoUsuario.identidad,
        'telefono': nuevoUsuario.telefono,
        'direccion': nuevoUsuario.direccion,
        'referencia': nuevoUsuario.referencia,
        'tipoUsuario': nuevoUsuario.tipoUsuario,
      });

      return ('Exito');
    } catch (error) {
      return ('Error al modificar el usuario: $error');
    }
  }

  void cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
  }
}
