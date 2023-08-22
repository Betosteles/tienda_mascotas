import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/VariableControler/categoria_animales_controller.dart';
import 'package:tienda_mascotas/src/VariableControler/categoria_producto_controller.dart';
import 'package:tienda_mascotas/src/constantes/routes.dart';
//import '../VariableControler/amount_product_controller.dart';
import '../VariableControler/amount_product_controller.dart';
import '../models/producto.dart';
import '../providers/carrito_provider.dart';
import '../providers/producto_provider.dart';
import 'package:get/get.dart';
import '../providers/usuarios_provider.dart';
import '../widgets/snackbar_helper.dart';

class TiendaPage extends StatelessWidget {
  const TiendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = ProductoProvider();
    final categoriaAnimales =
        Get.put<CategoriaAnimalesController>(CategoriaAnimalesController());
    final categoriaProducto =
        Get.put<CategoriaProductosController>(CategoriaProductosController());

    if (categoriaAnimales.currentAnimalesCategory == 0 &&
        categoriaProducto.currentProductosCategory == 0) {
      return // MaterialApp(
          //   routes: routes,
          //   home:
          Scaffold(
        appBar: AppBar(
          title: const Text('Tienda',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ) // Peso de fuente opcional
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
          builder:
              (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
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
    } else {
      return // MaterialApp(
          //   routes: routes,
          //   home:

          Scaffold(
        appBar: AppBar(
            title: const Text('Tienda',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ) // Peso de fuente opcional
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
          builder:
              (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
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
  }
}

class ListaProductos extends StatelessWidget {
  const ListaProductos({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot<List<Producto>> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.data!.isEmpty) {
      return const Center(
        child: Text("No se encontraron Productos"),
      );
    }

    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        final product = snapshot.data![index];

        return ItemProduct(product: product);
      },
    );
  }
}

class ItemProduct extends StatelessWidget {
 const ItemProduct({
    super.key,
    required this.product,
  });

  final Producto product;
  


  @override
  Widget build(BuildContext context) {
    final carritoProvider = CarritoService();
    final amountControler = Get.put<AmountProductController>(AmountProductController(), tag: product.productoId.toString());

    return FutureBuilder<int>(
      future: carritoProvider
          .obtenerCantidadProductoEnCarrito(product.productoId.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  const CircularProgressIndicator(); 
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final cantidadEnCarrito = snapshot.data ?? 0;
        amountControler.currentAmount = cantidadEnCarrito;

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.detalleProducto.name,
                arguments: product);
          },
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      title:  Text(product.nombre),
                      trailing: cantidadEnCarrito > 0
                          ? Obx(() =>  Text(
                              "(${amountControler.currentAmount.toString()})",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold, // Agrega negrita
                                fontSize: 16,
                              ),
                            ))
                          : const Text("") // Muestra la cantidad en el carrito
                      )
                ),
                Image.network(
                  product.imagenes,
                  height: 200,
                  fit: BoxFit.fitHeight,
                ),
                ListTile(
                  title: Text(product.descripcion),
                  trailing: Text(
                    '\$${product.precio}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
