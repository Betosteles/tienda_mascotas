import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tienda_mascotas/src/models/carrito_model.dart';




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
      String uid, int idProducto, int cantidad, double precio) async {
    await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('carrito')
        .doc(idProducto.toString())
        .set({
      'cantidad': cantidad,
      'precio' : precio
    });
  }

  Future<Carrito> obtenerCarrito() async {

    Map<String, dynamic> carrito = {};

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null){
      return Carrito(items: carrito);
    }

    QuerySnapshot carritoSnapshot = await _firestore
        .collection('usuarios')
        .doc(user.uid)
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

    return Carrito(items: carrito);
  }

Future<void> incrementarCantidadProductoEnCarrito(
    String uid, String idProducto) async {
  DocumentReference productoRef = _firestore
      .collection('usuarios')
      .doc(uid)
      .collection('carrito')
      .doc(idProducto);

  DocumentSnapshot productoSnapshot = await productoRef.get();

  Map<String, dynamic>? data = productoSnapshot.data() as Map<String, dynamic>?;

  

  if (productoSnapshot.exists) {
    
    if (data != null && data['cantidad'] != null) {
      int cantidadActual = (data['cantidad'] as num).toInt();
      double precioActual = (data['precio'] as num).toDouble();
      await productoRef.update({
        'cantidad': cantidadActual + 1,
        'precio' : precioActual,
      });
    }
  } else {
    await agregarProductoAlCarrito(uid, int.parse(idProducto), 1, data?['precio']);
  }
}

 Future<int> obtenerCantidadProductoEnCarrito(String idProducto) async {

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null){
      return -1;
    }


    DocumentSnapshot productoSnapshot = await _firestore
        .collection('usuarios')
        .doc(user.uid)
        .collection('carrito')
        .doc(idProducto)
        .get();

    if (productoSnapshot.exists) {
      Map<String, dynamic>? data = productoSnapshot.data() as Map<String, dynamic>?;
      if (data != null && data['cantidad'] != null) {
        return (data['cantidad'] as num).toInt();
      }
    }

    return 0; // Si no se encuentra el producto en el carrito, se asume cantidad 0.
  }

  Future<int> obtenerSumaCantidadesEnCarrito() async {
  int sumaTotal = 0;

  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return sumaTotal;
  }

  QuerySnapshot carritoSnapshot = await _firestore
      .collection('usuarios')
      .doc(user.uid)
      .collection('carrito')
      .get();

  for (QueryDocumentSnapshot doc in carritoSnapshot.docs) {
    dynamic data = doc.data();
    if (data != null && data['cantidad'] != null) {
      sumaTotal += (data['cantidad'] as num).toInt();
    }
  }

  return sumaTotal;
}



  Future<double> calcularTotalFactura() async {
    double total = 0.0;

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return total;
    }

    QuerySnapshot carritoSnapshot = await _firestore
        .collection('usuarios')
        .doc(user.uid)
        .collection('carrito')
        .get();

    for (QueryDocumentSnapshot doc in carritoSnapshot.docs) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null && data['cantidad'] != null && data['precio'] != null) {
        int cantidad = (data['cantidad'] as num).toInt();
        double precio = (data['precio'] as num).toDouble();
        total += cantidad * precio;
      }
    }

    return total;
  }
}


