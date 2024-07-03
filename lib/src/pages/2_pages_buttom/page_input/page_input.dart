import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/client_model.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';
import 'package:servicemangerapp/src/pages/widgets/cameraWidget.dart';
import 'package:servicemangerapp/src/pages/widgets/signatureWidget.dart';

class PageInput extends StatefulWidget {
  PageInput({super.key});

  @override
  State<PageInput> createState() => _PageInputState();
}

class _PageInputState extends State<PageInput> {
  final TextEditingController _equipmentController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _accessoriesController = TextEditingController();
  final TextEditingController _defectController = TextEditingController();

  ClientsProvider clientController = Get.find();
  var nameClient = ''.obs;
  var phoneClient = ''.obs;
  var emailClient = ''.obs;
  List<String> listImagePath = [];
  List<dynamic> listSignData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrada de Equipamento'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Cliente',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    iconSize: 30,
                    onPressed: () async {
                      clientController.controlAddClientPage.value = true;
                      Client addClient = await Get.to(() => PageListClientes());
                      nameClient.value = addClient.name;
                      phoneClient.value = addClient.phone;
                      emailClient.value = addClient.email;
                      clientController.controlAddClientPage.value = false;
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade200),
                height: 100,
                width: double.infinity,
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Nome: ${nameClient.value}'),
                      Text('Telefone: ${phoneClient.value}'),
                      Text('Email: ${emailClient.value}')
                    ],
                  ),
                ),
              ),
              TextFormField(
                controller: _equipmentController,
                decoration: const InputDecoration(labelText: 'Equipamento'),
              ),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(labelText: 'Marca'),
              ),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Modelo'),
              ),
              TextFormField(
                controller: _accessoriesController,
                decoration: const InputDecoration(labelText: 'Acessórios'),
              ),
              TextFormField(
                maxLines: 5,
                controller: _defectController,
                decoration:
                    const InputDecoration(labelText: 'Descrição do defeito'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Fotos',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              CameraWidget(
                finalReturn: (files) {
                  for (var x in files) {
                    listImagePath.add(x);
                  }
                },
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Assinatura',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Signaturewidget(
                dataSign: (uint8List) {
                  setState(() {
                    if (uint8List.isEmpty) {
                      listSignData.clear();
                    } else {
                      for (var x in uint8List) {
                        listSignData.add(x);
                      }
                    }
                  });
                },
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              ElevatedButton(
                onPressed: () {
                  print('Assinatura: $listSignData');
                  for (var x in listImagePath) {
                    print('Path: $x');
                  }
                },
                child: const Text('Salvar Ordem de Serviço'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
