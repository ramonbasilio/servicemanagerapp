import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';

class Confirmationwidget {
  ManagerProvider clientController = Get.find();
  Future<void> showConfirmationDialog(BuildContext context, String id) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // O usuário deve tocar em um dos botões
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Confirmar Exclusão'),
            content: Text('Você tem certeza que deseja excluir este item?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Get.back(); // Fecha o diálogo
                },
              ),
              TextButton(
                child: Text('Excluir'),
                onPressed: () {
                  clientController.deleteProvider(id: id);
                  Navigator.of(context).pop();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageListClientes(),
                      ));

                  (context);
                  // Fecha o diálogo
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Item excluído com sucesso!')));
                },
              ),
            ],
          );
        });
  }
}
