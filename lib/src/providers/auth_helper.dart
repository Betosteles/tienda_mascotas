// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';

class AuthHelper {
  static Future<void> checkLoggedInUser(BuildContext context, FirebaseAuth auth) async {
    final user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(uid)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        String userType = userData['tipoUsuario'];

        if (userType == 'User') {
          Navigator.pop(context);
          Navigator.pushNamed(context, MyRoutes.tiendaNav.name);
        } else if (userType == 'Admin') {
          Navigator.pop(context);
          Navigator.pushNamed(context, MyRoutes.admin.name);
        } else {
          // Si el tipo de usuario no es reconocido, manejarlo de acuerdo a tus necesidades
        }
      }
    }
  }
}
