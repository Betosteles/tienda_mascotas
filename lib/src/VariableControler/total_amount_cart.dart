import 'package:get/get.dart';

import '../providers/carrito_provider.dart';

void refreshAmount() async{
    final carrito = CarritoService();
    final total = Get.find<TotalAmountProductController>();
    total.currentTotalAmount = await carrito.obtenerSumaCantidadesEnCarrito();
  }

class TotalAmountProductController extends GetxController {
  final _currentTotalAmount = 0.obs;
  final carrito = CarritoService();

  @override
  void onInit() async {
      _currentTotalAmount.value = await carrito.obtenerSumaCantidadesEnCarrito();
    super.onInit();
  }
  

  //getters y setters
  int get currentTotalAmount => _currentTotalAmount.value;
  set currentTotalAmount(int value) => _currentTotalAmount.value = value;
}


  