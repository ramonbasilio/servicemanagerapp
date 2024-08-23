import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:servicemangerapp/src/extensions/extensions.dart';
import 'package:servicemangerapp/src/pages/3_parts/page_part.dart';

class PageQuote extends StatelessWidget {
  ServiceOrder serviceOrder;
  PageQuote({required this.serviceOrder, super.key});

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
                            'Nome: ${serviceOrder.client.name}',
                          ),
                          Text(
                            'Email: ${serviceOrder.client.email}',
                          ),
                          Text(
                            'Telefone: ${serviceOrder.client.phone}',
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
                            'Equipamento: ${serviceOrder.equipment}',
                          ),
                          Text(
                            'Marca: ${serviceOrder.brand}',
                          ),
                          Text(
                            'Modelo: ${serviceOrder.model}',
                          ),
                          Text(
                            'Defeito: ${serviceOrder.defect}',
                          ),
                          Text(
                            'Chegada na assis. técnica: ${serviceOrder.date!.dateTimeFormart()}',
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
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Sem peças',
                              ),
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
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const SizedBox(
              width: double.maxFinite,
              height: 150,
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'BOTTOM SHEET TESTE - AS PEÇAS APARECERÃO NESSA SESSÃO'),
              )));
        });
  }
}
