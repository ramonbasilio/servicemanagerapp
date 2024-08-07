import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/data/repository/firebase_cloud_firestore.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_add_clients.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_edit_client.dart';

class PageListClientes extends StatelessWidget {
  PageListClientes({super.key});
  ManagerProvider clientController = Get.find();

  @override
  Widget build(BuildContext context) {
    clientController.getAllClientsProvider();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Clientes'),
      ),
      floatingActionButton:
          Obx(() => !clientController.controlAddClientPage.value
              ? FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    Get.to(() => const ClienteCadastroPage());
                  },
                )
              : SizedBox.fromSize()),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //ext('Total de clientes cadastrados: ${clientController.lengthClients}'),
            SizedBox(
              height: 80,
              child: Row(children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    size: 20,
                    Icons.search,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Pesquisar...'),
                    onChanged: (value) async {
                      await clientController.searchClient(name: value);
                    },
                  ),
                )
              ]),
            ),

            Flexible(
              child: Obx(
                () => clientController.foundClients.isEmpty
                    ? const Text('Nenhum cliente cadastrado')
                    : ListView.builder(
                        itemCount: clientController.foundClients.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  if (clientController
                                      .controlAddClientPage.value) {
                                    Get.back(
                                        result: clientController
                                            .foundClients[index]);
                                  } else {
                                    Get.to(() => PageEditClient(
                                        client: clientController
                                            .foundClients[index]));
                                  }
                                },
                                leading: CircleAvatar(
                                  child: Text(clientController
                                      .foundClients[index].name[0]
                                      .toUpperCase()),
                                ),
                                title: Text((clientController
                                    .foundClients[index].name)),
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
