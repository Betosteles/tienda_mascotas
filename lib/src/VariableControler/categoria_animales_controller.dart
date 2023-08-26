import 'package:get/get.dart';

class CategoriaAnimalesController extends GetxController {
  final _currentAnimalesCategory = 0.obs;

  //getters y setters
  int get currentAnimalesCategory => _currentAnimalesCategory.value;
  set currentAnimalesCategory(int value) =>
      _currentAnimalesCategory.value = value;
}
