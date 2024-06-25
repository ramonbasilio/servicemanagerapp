import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/model/client_model.dart';
import 'package:servicemangerapp/src/data/provider/camera_provider.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_input/page_preview_camera.dart';
import 'package:servicemangerapp/src/pages/widgets/cameWidget.dart';

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
  File? arquivo;
  List<File> myImages = [];

  showPreview(File file, BuildContext context) async {
    // final myProvider = Provider.of<CameraProvider>(context, listen: false);
    // File? arq = await Get.to(() => );
    // if (arq != null) {
    //   setState(() {
    //     for (var x in myProvider.listFileImage) {
    //       print('Files: $x');
    //     }
    //     arquivo = arq;
    //   });
    //   Get.back();
    // }
  }

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
                      ClientModel addClient =
                          await Get.to(() => PageListClientes());
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
                    const InputDecoration(labelText: 'Discrição do defeito'),
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
              const CameraWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
