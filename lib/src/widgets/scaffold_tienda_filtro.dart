import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tienda_mascotas/src/widgets/listaProductos.dart';

import '../VariableControler/categoria_animales_controller.dart';
import '../VariableControler/categoria_producto_controller.dart';
import '../constantes/routes.dart';
import '../constantes/tema.dart';
import '../models/producto.dart';

final categoriaAnimales =
    Get.put<CategoriaAnimalesController>(CategoriaAnimalesController());
final categoriaProducto =
    Get.put<CategoriaProductosController>(CategoriaProductosController());

Scaffold getScaffoldTiendaSinFiltrar(context, productProvider) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Tienda',
          style: getEstiloTienda()
          ),
      backgroundColor: Colors.green[900],
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.animal.name);
          },
        ),
      ],
    ),
    body: FutureBuilder(
      future: productProvider.getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: Text('No hay conexion'),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error,
                  size: 90,
                ),
                Text(snapshot.error.toString()),
              ],
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListaProductos(snapshot: snapshot);
      },
    ),
  );
}

Scaffold getScaffoldTiendaFiltrada(context, productProvider) {
  return Scaffold(
    appBar: AppBar(
        title: Text('Tienda',
            style: getEstiloTienda()
            ),
        backgroundColor: Colors.green[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              categoriaAnimales.currentAnimalesCategory = 0;
              categoriaProducto.currentProductosCategory = 0;

              Navigator.pushNamed(context, MyRoutes.tiendaNav.name);
              // Agrega aquí la lógica para recargar la página o realizar la acción deseada.
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.animal.name);
            },
          )
        ]),
    body: FutureBuilder(
      future: productProvider.getProductoByAC(
          animalId: categoriaAnimales.currentAnimalesCategory,
          categoriaID: categoriaProducto.currentProductosCategory),
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: Text('No hay conexion'),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error,
                  size: 90,
                ),
                Text(snapshot.error.toString()),
              ],
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListaProductos(snapshot: snapshot);
      },
    ),
  );
}
