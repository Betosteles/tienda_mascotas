import 'package:flutter/material.dart';

import '../providers/carrito_provider.dart';

class TotalCarritoWidget extends StatelessWidget {
  final CarritoService carritoProvider = CarritoService();

  TotalCarritoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: carritoProvider.calcularTotalFactura(),
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final total = snapshot.data ?? 0.0;
          return Text("Total: $total",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
        }
      },
    );
  }
}
