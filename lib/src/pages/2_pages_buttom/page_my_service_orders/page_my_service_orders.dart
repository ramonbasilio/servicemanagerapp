import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_edit_client.dart';

class PageMyServiceOrders extends StatelessWidget {
  PageMyServiceOrders({super.key});
  final ManagerProvider _managerProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    _managerProvider.getAllServiceOrderProvider();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Ordens de Serviço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //ext('Total de clientes cadastrados: ${clientController.lengthClients}'),
            // SizedBox(
            //   height: 80,
            //   child: Row(children: [
            //     const Padding(
            //       padding: EdgeInsets.only(right: 10.0),
            //       child: Icon(
            //         size: 20,
            //         Icons.search,
            //       ),
            //     ),
            //     Expanded(
            //       child: TextField(
            //         decoration: const InputDecoration(hintText: 'Pesquisar...'),
            //         onChanged: (value) async {
            //           await clientController.searchClient(name: value);
            //         },
            //       ),
            //     )
            //   ]),
            // ),

            Flexible(
              child: Obx(
                () => _managerProvider.allServiceOrder.isEmpty
                    ? const Text('Nenhum cliente cadastrado')
                    : ListView.builder(
                        itemCount: _managerProvider.allServiceOrder.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                // onTap: () {
                                //   if (_managerProvider
                                //       .controlAddClientPage.value) {
                                //     Get.back(
                                //         result: clientController
                                //             .foundClients[index]);
                                //   } else {
                                //     Get.to(() => PageEditClient(
                                //         client: clientController
                                //             .foundClients[index]));
                                //   }
                                // },
                                leading: Text(_managerProvider
                                    .allServiceOrder[index].client.name),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text((_managerProvider
                                        .allServiceOrder[index].equipment)),
                                    Text(
                                        'Marca: ${(_managerProvider.allServiceOrder[index].brand)}'),
                                    Text(
                                        'Modelo: ${(_managerProvider.allServiceOrder[index].model)}'),
                                  ],
                                ),

                                subtitle: Text((_managerProvider
                                    .allServiceOrder[index].defect)),
                              ),
                              const Divider()
                            ],
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
