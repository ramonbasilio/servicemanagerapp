import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/model/receiver_doc.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/data/repository/firebase_cloud_firestore.dart';
import 'package:servicemangerapp/src/data/repository/firebase_storage.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';
import 'package:servicemangerapp/src/pages/widgets/cameraWidget.dart';
import 'package:servicemangerapp/src/pages/widgets/signatureWidget.dart';
import 'package:servicemangerapp/src/utils/utils.dart';

class PageInput extends StatefulWidget {
  const PageInput({super.key});

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
  Firebasetorage firebasetorage = Get.put(Firebasetorage());
  var nameClient = ''.obs;
  var phoneClient = ''.obs;
  var emailClient = ''.obs;
  List<String> listImagePath = [];
  List<int> listSignData = [];
  final _formKey = GlobalKey<FormState>();
  var validateClientControll = false.obs;
  var validateSignControll = false.obs;
  int? numberServiceOrder;
  Client? addClient;

  @override
  Widget build(BuildContext context) {
    numberServiceOrder = Utils.gerenateNumerServiceOrder();

    return Consumer<Firebasetorage>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Entrada de Equipamento'),
          actions: [
            IconButton(
                onPressed: () async {
                  bool validate1 = false;
                  bool validate2 = false;
                  bool validate3 = false;
                  if (_formKey.currentState!.validate()) {
                    validate1 = true;
                  }

                  if (nameClient.isEmpty) {
                    validateClientControll.value = true;
                  } else {
                    validate2 = true;
                    validateClientControll.value = false;
                  }
                  if (listSignData.isEmpty) {
                    validateSignControll.value = true;
                  } else {
                    validate3 = true;
                    validateSignControll.value = false;
                  }
                  if (validate1 && validate2 && validate3) {
                    await Firebasetorage().uploadImage(
                      pathList: listImagePath,
                      signList: listSignData,
                      clientId: addClient!.id!,
                      numberDoc: numberServiceOrder!.toString(),
                      clientName: addClient!.name,
                    );
                    print('URL: ${value.urlDownloadSign}');
                    print('URL: ${value.listFileImage}');
                    ReceiverDoc receiverDoc = ReceiverDoc(
                      client: addClient!,
                      numberDoc: numberServiceOrder!.toString(),
                      equipment: _equipmentController.text,
                      brand: _brandController.text,
                      model: _modelController.text,
                      accessories: _accessoriesController.text,
                      defect: _defectController.text,
                      pathImages: value.listFileImage,
                      pathSign: value.urlDownloadSign,
                    );
                    await FirebaseCloudFirestore()
                        .registerReceiverOrder(receiverDoc: receiverDoc);
                  }
                },
                icon: const Icon(Icons.save)),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ordem de Serviço: $numberServiceOrder',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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
                          addClient = await Get.to(() => PageListClientes());
                          nameClient.value = addClient!.name;
                          phoneClient.value = addClient!.phone;
                          emailClient.value = addClient!.email;
                          clientController.controlAddClientPage.value = false;
                          validateClientControll.value = false;
                        },
                        icon: const Icon(Icons.add),
                      ),
                      validateClientControll.value
                          ? const Text(
                              'Adicione um cliente',
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox.shrink()
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o tipo de equipamento';
                      } else {
                        return null;
                      }
                    },
                    controller: _equipmentController,
                    decoration: const InputDecoration(labelText: 'Equipamento'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira a marca de equipamento';
                      } else {
                        return null;
                      }
                    },
                    controller: _brandController,
                    decoration: const InputDecoration(labelText: 'Marca'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o modelo de equipamento';
                      } else {
                        return null;
                      }
                    },
                    controller: _modelController,
                    decoration: const InputDecoration(labelText: 'Modelo'),
                  ),
                  TextFormField(
                    controller: _accessoriesController,
                    decoration: const InputDecoration(labelText: 'Acessórios'),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira a descrição do defeito';
                      } else {
                        return null;
                      }
                    },
                    maxLines: 5,
                    controller: _defectController,
                    decoration: const InputDecoration(
                        labelText: 'Descrição do defeito'),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Assinatura',
                          style: TextStyle(fontSize: 20),
                        ),
                        validateSignControll.value
                            ? const Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Assine o documento',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : const SizedBox.shrink()
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
