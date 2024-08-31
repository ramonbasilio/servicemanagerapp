import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/cartPart.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/data/provider/listPart_provider.dart';
import 'package:servicemangerapp/src/pages/3_parts/page_part.dart';

class PageConfirmationPart extends StatelessWidget {
  List<CartPart> part;
  PageConfirmationPart({required this.part, super.key});

  List<String> valuesPrices = [];
  ListPartController listPartController = Get.find();

  @override
  Widget build(BuildContext context) {
    listPartController.updatePriceTotal();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peças do Orçamento'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.off(() => PagePart());
          },
        ),
      ),
      body: Column(
        children: [
          Flexible(child: Obx(() {
            return ListView.builder(
                itemCount: listPartController.partItemsList.length,
                itemBuilder: (context, index) {
                  final part = listPartController.partItemsList[index];
                  return ListTile(
                    tileColor: part.quantity.value == 0
                        ? Color.fromARGB(255, 247, 78, 95)
                        : Colors.white,
                    title: Text(part.name),
                    subtitle: Obx(() => Text(part.quantity.toString())),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (part.quantity > 1) {
                              listPartController.updateItemQuantity(
                                  part, part.quantity.value - 1);
                            } else {
                              listPartController.updateItemQuantity(part, 0);
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () =>
                              listPartController.updateItemQuantity(
                                  part, part.quantity.value + 1),
                        ),
                      ],
                    ),
                  );
                });
          })),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 120,
        child: Column(
          children: [
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    'Total: R\$ ${listPartController.totalPrice.value.toStringAsFixed(2)}'),
              );
            }),
            ElevatedButton(
                onPressed: () {
                  int numberOfPagesToGoBack = 1;
                  for (int i = 0; i < numberOfPagesToGoBack; i++) {
                    Get.back();
                  }
                },
                child: Text('Enviar para orçamento'))
          ],
        ),
      ),
    );
  }
}
