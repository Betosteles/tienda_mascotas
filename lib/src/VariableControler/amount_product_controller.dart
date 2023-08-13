import 'package:get/get.dart';

class AmountProductController extends GetxController {
  final _currentAmount = 0.obs;

  //getters y setters
  int get currentAmount => _currentAmount.value;
  set currentAmount(int value) => _currentAmount.value = value;
}