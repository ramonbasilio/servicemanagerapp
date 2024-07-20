import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/data/provider/provider.dart';
import 'package:servicemangerapp/src/pages/widgets/cameraWidget.dart';
import 'package:servicemangerapp/src/pages/widgets/signatureWidget.dart';

class PageEditServiceOrder extends StatefulWidget {
  ServiceOrder serviceOrder;
  PageEditServiceOrder({required this.serviceOrder, super.key});

  @override
  State<PageEditServiceOrder> createState() => _PageEditServiceOrderState();
}

class _PageEditServiceOrderState extends State<PageEditServiceOrder> {
  final TextEditingController _equipmentController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _accessoriesController = TextEditingController();
  final TextEditingController _defectController = TextEditingController();
  ManagerProvider managerProvider = Get.find();
  late String nameClient;
  late String phoneClient;
  late String emailClient;
  List<String> listImagePath = [];
  List<int> listSignData = [];

  final _formKey = GlobalKey<FormState>();
  var loadControll = false.obs;
  var validateClientControll = false.obs;
  var validateSignControll = false.obs;
  Client? addClient;

  @override
  void initState() {
    final widgetServiceOrder = widget.serviceOrder;
    nameClient = widgetServiceOrder.client.name;
    phoneClient = widgetServiceOrder.client.phone;
    emailClient = widgetServiceOrder.client.email;
    _equipmentController.text = widgetServiceOrder.equipment;
    _brandController.text = widgetServiceOrder.brand;
    _modelController.text = widgetServiceOrder.model;
    _accessoriesController.text = widgetServiceOrder.accessories;
    _defectController.text = widgetServiceOrder.defect;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyProvider value = Provider.of<MyProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ordem de Serviço ${widget.serviceOrder.numberDoc}'),
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
                  // loadControll.value = true;
                  // await Firebasetorage().uploadImage(
                  //     pathList: listImagePath,
                  //     signList: listSignData,
                  //     clientId: addClient!.id!,
                  //     numberDoc: widget.numberServiceOrder.toString(),
                  //     clientName: addClient!.name,
                  //     context: context);

                  // ServiceOrder receiverDoc = ServiceOrder(
                  //   client: addClient!,
                  //   numberDoc: widget.numberServiceOrder.toString(),
                  //   equipment: _equipmentController.text,
                  //   brand: _brandController.text,
                  //   model: _modelController.text,
                  //   accessories: _accessoriesController.text,
                  //   defect: _defectController.text,
                  //   pathImages: value.getList(),
                  //   pathSign: value.getUrl(),
                  // );
                  // if (context.mounted) {
                  //   await FirebaseCloudFirestore().registerReceiverOrder(
                  //     receiverDoc: receiverDoc,
                  //     context: context,
                  //   );
                  // }
                  // loadControll.value = false;
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
                const Text(
                  'Cliente',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade200),
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Nome: $nameClient'),
                      Text('Telefone: $phoneClient'),
                      Text('Email: $emailClient')
                    ],
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
                      listImagePath.add(x);
                    }
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
