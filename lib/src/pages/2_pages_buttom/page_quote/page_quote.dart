import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:servicemangerapp/src/data/provider/listPart_provider.dart';
import 'package:servicemangerapp/src/extensions/extensions.dart';
import 'package:servicemangerapp/src/pages/3_parts/page_part.dart';

class PageQuote extends StatefulWidget {
  ServiceOrder serviceOrder;
  PageQuote({required this.serviceOrder, super.key});

  @override
  State<PageQuote> createState() => _PageQuoteState();
}

class _PageQuoteState extends State<PageQuote> {
  ListPartController listPartController = Get.put(ListPartController());

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamento'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Cliente',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: const Border(
                          left: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade200,
                      ),
                      //margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome: ${widget.serviceOrder.client.name}',
                          ),
                          Text(
                            'Email: ${widget.serviceOrder.client.email}',
                          ),
                          Text(
                            'Telefone: ${widget.serviceOrder.client.phone}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                'Equipamento',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: const Border(
                          left: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade200,
                      ),
                      //margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Equipamento: ${widget.serviceOrder.equipment}',
                          ),
                          Text(
                            'Marca: ${widget.serviceOrder.brand}',
                          ),
                          Text(
                            'Modelo: ${widget.serviceOrder.model}',
                          ),
                          Text(
                            'Defeito: ${widget.serviceOrder.defect}',
                          ),
                          Text(
                            'Chegada na assis. técnica: ${widget.serviceOrder.date!.dateTimeFormart()}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0),
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.grey.shade500,
                  //     child: IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(
                  //         Icons.add,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const Text(
                'Diagnostico',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: const Border(
                          left: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade200,
                      ),
                      //margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Descrição do defeito:',
                          ),
                          TextFormField(
                            minLines: 1,
                            maxLines: 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Correções aplicadas: ',
                          ),
                          TextFormField(
                            minLines: 1,
                            maxLines: 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Teste realizados: ',
                          ),
                          TextFormField(
                            minLines: 1,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                'Peças',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _showBottomSheet(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: const Border(
                            left: BorderSide(
                              color: Colors.black,
                              width: 5.0,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade200,
                        ),
                        //margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Obx(() => Text(
                                    listPartController.partItemsList.isEmpty
                                        ? 'Sem peças'
                                        : 'PEÇAS ADICIONADAS',
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade500,
                      child: IconButton(
                        onPressed: () {
                          Get.to(() => const PagePart());
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    listPartController.updatePriceTotal();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.maxFinite,
          height: 200,
          child: Column(
            children: [
              Flexible(
                child: Obx(
                  () {
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
                                      listPartController.updateItemQuantity(
                                          part, 0);
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
                  },
                ),
              ),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      'Total: R\$ ${listPartController.totalPrice.value.toStringAsFixed(2)}'),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
