import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/extensions/extensions.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_my_service_orders/page_edit_service_order.dart';
import 'package:servicemangerapp/src/pages/widgets/deleteServiceOrderConfirmation.dart';

class PageListServiceOrders extends StatelessWidget {
  PageListServiceOrders({super.key});
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
            Flexible(
              child: Obx(
                () => _managerProvider.allServiceOrder.isEmpty
                    ? const Text('Nenhum Ordem de Serviço')
                    : ListView.builder(
                        itemCount: _managerProvider.allServiceOrder.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  _showBottomSheet(context,
                                      _managerProvider.allServiceOrder[index]);
                                },
                                leading: Column(
                                  children: [
                                    Text(
                                      _managerProvider
                                          .allServiceOrder[index].client.name,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(_managerProvider
                                        .allServiceOrder[index].date!
                                        .dateTimeFormart())
                                  ],
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        ('Dispositivo: ${_managerProvider.allServiceOrder[index].numberDoc}')),
                                    Text(
                                        ('Dispositivo: ${_managerProvider.allServiceOrder[index].equipment}')),
                                    Text(
                                        'Marca: ${(_managerProvider.allServiceOrder[index].brand)}'),
                                    Text(
                                        'Modelo: ${(_managerProvider.allServiceOrder[index].model)}'),
                                  ],
                                ),
                                subtitle: Text(
                                  ('Defeito: ${_managerProvider.allServiceOrder[index].defect}'),
                                  style: const TextStyle(fontSize: 15),
                                ),
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

  void _showBottomSheet(BuildContext context, ServiceOrder serviceOrder) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.monetization_on),
                    title: const Text('Gerar Orçamento'),
                    onTap: () => {
                        }),
                ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Editar'),
                    onTap: () => {
                          Get.back(),
                          Get.to(() => PageEditServiceOrder(
                                serviceOrder: serviceOrder,
                              )),
                        }),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('Compartilhar'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Deletar'),
                  onTap: () => {
                    Get.back(),
                    DeleteServiceOrderConfirmation()
                        .showConfirmationDialog(context, serviceOrder.numberDoc)
                  },
                ),
              ],
            ),
          );
        });
  }
}
