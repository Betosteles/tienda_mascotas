import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/VariableControler/categoria_animales_controller.dart';
import 'package:tienda_mascotas/src/VariableControler/categoria_producto_controller.dart';
import '../providers/producto_provider.dart';
import 'package:get/get.dart';
import '../widgets/scaffold_tienda_filtro.dart';

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
      return getScaffoldTiendaSinFiltrar(context, productProvider);
    } else {
      return getScaffoldTiendaFiltrada(context, productProvider);
    }
  }
}
