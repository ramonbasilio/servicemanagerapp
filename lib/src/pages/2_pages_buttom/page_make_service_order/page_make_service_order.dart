import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/data/provider/provider.dart';
import 'package:servicemangerapp/src/data/repository/firebase_cloud_firestore.dart';
import 'package:servicemangerapp/src/data/repository/firebase_storage.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_clients/page_list_clientes.dart';
import 'package:servicemangerapp/src/pages/widgets/cameraWidget.dart';
import 'package:servicemangerapp/src/pages/widgets/signatureWidget.dart';
import 'package:servicemangerapp/src/utils/utils.dart';

class PageMakeServiceOrder extends StatefulWidget {
  int numberServiceOrder;
  PageMakeServiceOrder({required this.numberServiceOrder, super.key});

  @override
  State<PageMakeServiceOrder> createState() => _PageMakeServiceOrderState();
}

class _PageMakeServiceOrderState extends State<PageMakeServiceOrder> {
  final TextEditingController _equipmentController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _accessoriesController = TextEditingController();
  final TextEditingController _defectController = TextEditingController();
  ManagerProvider clientController = Get.find();
  //Firebasetorage firebasetorage = Get.put(Firebasetorage());
  var nameClient = ''.obs;
  var phoneClient = ''.obs;
  var emailClient = ''.obs;
  List<String> listImagePath = [];
  List<int> listSignData = [];
  final _formKey = GlobalKey<FormState>();
  var loadControll = false.obs;
  var validateClientControll = false.obs;
  var validateSignControll = false.obs;
  Client? addClient;

  @override
  Widget build(BuildContext context) {
    MyProvider value = Provider.of<MyProvider>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordem de Serviço ${widget.numberServiceOrder}'),
        actions: [
          Obx(
            () => TextButton(
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
                if (value.controllSign == false) {
                  setState(() {
                    validateSignControll.value = true;
                  });
                } else {
                  validate3 = true;
                  setState(() {
                    validateSignControll.value = false;
                  });
                }
                if (validate1 && validate2 && validate3) {
                  loadControll.value = true;
                  await Firebasetorage().uploadImage(
                      pathList: listImagePath,
                      signList: listSignData,
                      clientId: addClient!.id!,
                      numberDoc: widget.numberServiceOrder.toString(),
                      clientName: addClient!.name,
                      context: context);

                  ServiceOrder receiverDoc = ServiceOrder(
                    client: addClient!,
                    numberDoc: widget.numberServiceOrder.toString(),
                    equipment: _equipmentController.text,
                    brand: _brandController.text,
                    model: _modelController.text,
                    accessories: _accessoriesController.text,
                    defect: _defectController.text,
                    pathImages: value.getList(),
                    pathSign: value.getUrl(),
                  );
                  if (context.mounted) {
                    await FirebaseCloudFirestore().registerReceiverOrder(
                      receiverDoc: receiverDoc,
                      context: context,
                    );
                  }
                  loadControll.value = false;
                }
              },
              child: loadControll.value
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.save),
            ),
          ),
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
                        if (addClient != null) {
                          nameClient.value = addClient!.name;
                          phoneClient.value = addClient!.phone;
                          emailClient.value = addClient!.email;
                          validateClientControll.value = false;
                        }
                        clientController.controlAddClientPage.value = false;
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
                      print('imprimindo cada elemento: $x');
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
    );
  }
}
