import 'package:get/get.dart';

class CategoriaProductosController extends GetxController {
  final _currentProductosCategory = 0.obs;

  //getters y setters
  int get currentProductosCategory => _currentProductosCategory.value;
  set currentProductosCategory(int value) =>
      _currentProductosCategory.value = value;
}
