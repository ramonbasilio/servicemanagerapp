import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_my_service_orders/page_list_service_orders.dart';

class DeleteServiceOrderConfirmation {
  ManagerProvider managerProvider = Get.find();
  Future<void> showConfirmationDialog(BuildContext context, String id) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // O usuário deve tocar em um dos botões
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content:
                const Text('Você tem certeza que deseja excluir este item?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Get.back(); // Fecha o diálogo
                },
              ),
              TextButton(
                child: const Text('Excluir'),
                onPressed: () {
                  managerProvider.deleteProviderMethod(
                      colletion: 'Service Order', id: id);
                  Get.back();
                },
              ),
            ],
          );
        });
  }
}
