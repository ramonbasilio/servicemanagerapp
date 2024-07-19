import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';

class StatusServiceWidget extends StatelessWidget {
  StatusServiceWidget({
    super.key,
  });

  ManagerProvider managerProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    managerProvider.getAllClientsProvider();
    managerProvider.getAllServiceOrderProvider();
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const Text(
            'Status Serviços',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total de clientes'),
                    Obx(() =>
                        Text(managerProvider.foundClients.length.toString())),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Ordens de Serviços totais'),
                    Obx(() => Text(
                        managerProvider.allServiceOrder.length.toString())),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aguar. Aprovação'),
                    Text('-'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Prontos'),
                    Text('-'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
