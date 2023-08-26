import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/constantes/tema.dart';
import 'package:tienda_mascotas/src/providers/pedido_provider.dart';

import '../models/pedido.dart';

class VerPedidosPendientesPage extends StatelessWidget {
  const VerPedidosPendientesPage({super.key});
  
// ID Pedido 	Fecha 	Cliente 	Total 	Metodo de Pago 	Estado

  @override
Widget build(BuildContext context) {
    final pedidoProvider = PedidoProvider();

    return 
      Scaffold(
        appBar: AppBar(
          title: Text('Pedidos Pendientes',
          style: getEstiloTienda()),
      
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Pedido>>(
            future: pedidoProvider.getPedidosPorCliente(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
              } else if (snapshot.hasError) {
                return const Text('Error al cargar los pedidos'); // Muestra un mensaje de error si hay un problema
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No hay pedidos disponibles'); // Muestra un mensaje si no hay datos disponibles
              } else {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    Pedido detalle = snapshot.data![index];
                    return GestureDetector(
        
                      onTap: () {
        
                        
                         
                      },
        
                      child: SizedBox(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Fecha: ${detalle.fechaPedido}'),
                              subtitle: Text('Pedido: ${detalle.idPedido},    Metodo De pago: ${detalle.metodoPagoId == 1 ? "Transferencia Bancaria" : detalle.metodoPagoId == 2 ? "Contra Entrega" : "Otro Metodo De pago"}'),
                              //trailing:const Icon(Icons.remove_red_eye),
                              isThreeLine: true,
                            ),
                            const Divider(height: 0, thickness: 5, color: Colors.black,),
                          ],
                        ),
                        
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      )
    ;
  }
}