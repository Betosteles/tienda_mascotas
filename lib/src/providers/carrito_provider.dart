import 'package:cloud_firestore/cloud_firestore.dart';

class CarritoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> borrarCarrito(String uid) async {
    CollectionReference carritoRef =
        _firestore.collection('usuarios').doc(uid).collection('carrito');
    QuerySnapshot carritoSnapshot = await carritoRef.get();
    for (QueryDocumentSnapshot doc in carritoSnapshot.docs) {
      await carritoRef.doc(doc.id).delete();
    }   
  }

  Future<void> eliminarProductoDelCarrito(String uid, String idProducto) async {
    await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('carrito')
        .doc(idProducto)
        .delete();
  }

  Future<void> cambiarCantidadProductoEnCarrito(
      String uid, String idProducto, int nuevaCantidad) async {
    await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('carrito')
        .doc(idProducto)
        .update({
      'cantidad': nuevaCantidad,
    });
  }

  Future<void> agregarProductoAlCarrito(
      String uid, int idProducto, int cantidad) async {
    await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('carrito')
        .doc(idProducto.toString())
        .set({
      'cantidad': cantidad,
    });
  }

  Future<Map<String, dynamic>> obtenerCarrito(String uid) async {
    Map<String, dynamic> carrito = {};

    QuerySnapshot carritoSnapshot = await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('carrito')
        .get();

    for (QueryDocumentSnapshot doc in carritoSnapshot.docs) {
      String idProducto = doc.id;
      dynamic data = doc.data();

      if (data != null && data['cantidad'] != null) {
        int cantidad = data['cantidad'];
        carrito[idProducto] = cantidad;
      }
    }

    return carrito;
  }
}
