// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getInicio() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser;

  if (user != null) {
    String uid = user.uid;
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      String userType = userData['tipoUsuario'];

      return userType;
    }
  }
  return "LogOut";
}
