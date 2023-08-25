import 'package:flutter/material.dart';
import 'package:tienda_mascotas/src/models/pedido_detalle.dart';
import 'package:tienda_mascotas/src/providers/pedido_provider.dart';

import '../models/pedido.dart';
import '../providers/pedido_detalle_provider.dart';
import '../providers/pedido_estado_provider.dart';
import '../widgets/dropdown_button_estado_pedido.dart';
import '../widgets/list_tile_pedido_detalle_producto.dart';

class AdministrarPedidosPage extends StatelessWidget {
  const AdministrarPedidosPage({super.key });

  
  

  @override
Widget build(BuildContext context) {
    final pedidoProvider = PedidoDetalleProvider();
    final pedidoEstadoProvider = PedidoEstadoProvide();
    final args = ModalRoute.of(context)!.settings.arguments as Pedido;
    final ValueNotifier<String?> valorSeleccionadoController2 = ValueNotifier("1");

    

    return Scaffold(
        appBar: AppBar(
          title: const Text('Administrar Pedidos'),
        ),
        body: FutureBuilder<List<PedidoDetalle>>(
          future: pedidoProvider.getPedidoDetalle(args.idPedido),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
            } else if (snapshot.hasError) {
              return const Text('Error al cargar los pedidos'); // Muestra un mensaje de error si hay un problema
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No hay pedidos disponibles'); // Muestra un mensaje si no hay datos disponibles
            } else {
              return 
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            PedidoDetalle detalle = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                print(args.idPedido);
                              },
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    ListTilePedidoDetalleProducto(pedidoDetalle: detalle,),
                                    const Divider(height: 0, thickness: 5, color: Colors.black,),
                                  ],
                                  
                                ),
                                
                              ),
                            );
                          },                                      
                                    ),
                      ),
                      EstadoPedidoDropdown(
                      valorSeleccionadoController: valorSeleccionadoController2,
                      pedidoId: args.idPedido,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: (){

                        final valor = valorSeleccionadoController2.value;


                        if(valor!=null){
                            pedidoEstadoProvider.actualizarEstadoPedido(args.idPedido, int.parse(valor), context);

                        }
                        
                        
                      }, child: const Text("Guardar")),
                    )
                    ],
                  );
            }
          },
        ),
              
    );
  }
}
