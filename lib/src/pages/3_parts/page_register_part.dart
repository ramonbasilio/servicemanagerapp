import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/data/repository/firebase_cloud_firestore.dart';
import 'package:servicemangerapp/src/pages/3_parts/page_confirmation_part.dart';
import 'package:servicemangerapp/src/pages/widgets/camera/camera_init_mult_img.dart';
import 'package:servicemangerapp/src/pages/widgets/camera/camera_init_one_img.dart';
import 'package:servicemangerapp/src/pages/widgets/camera_widget_3.dart';

class PageRegisterPart extends StatefulWidget {
  const PageRegisterPart({super.key});

  @override
  State<PageRegisterPart> createState() => _PageRegisterPartState();
}

class _PageRegisterPartState extends State<PageRegisterPart> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<String> _unidades = ['Kg', 'Litro', 'Metro', 'Unidade', 'Caixa'];
  String stringImagePath = '';
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Peça',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da peça';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(
                  labelText: 'Detalhes',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira os detalhes';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  _showUnitBottomSheet(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _unitController,
                    decoration: const InputDecoration(
                      labelText: 'Unidade de medida',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecione a unidade';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço';
                  }
                  value = value.replaceAll(',', '.');
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um valor numérico válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // TextFormField(
              //   controller: _amountController,
              //   decoration: const InputDecoration(
              //     labelText: 'Quantidade',
              //   ),
              //   keyboardType: TextInputType.number,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Por favor, insira a quantidade';
              //     }
              //     if (int.tryParse(value) == null) {
              //       return 'Por favor, insira um valor inteiro válido';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 24),
              CameraInitOneImg(
                finalReturn: (String value) {
                  stringImagePath = value;
                },
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.8,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Text('Salvar na lista de peças')
              ],
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade100),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processando dados')),
                  );
                  Part part = Part.create(
                    partDetails: _detailsController.text,
                    partName: _nameController.text,
                    partUnid: _unitController.text,
                    partValue: _valueController.text,
                  );
                  FirebaseCloudFirestore().registerPart(part: part);

                  // Part partTest1 = Part.create(
                  //     partName: 'Tela Celular',
                  //     partUnid: 'Unidade',
                  //     partValue: '100,00',
                  //     partDetails: 'Tela Iphone-13');

                  // Part partTest2 = Part.create(
                  //     partName: 'Botão',
                  //     partUnid: 'Unidade',
                  //     partValue: '200,00',
                  //     partDetails: 'Tela Iphone-13');

                  // Part partTest3 = Part.create(
                  //     partName: 'Capinha',
                  //     partUnid: 'Unidade',
                  //     partValue: '100,00',
                  //     partDetails: 'Tela Iphone-13');

                  // List<Part> listPart = [];
                  // listPart.addAll([partTest1, partTest2, partTest3]);
                  // Get.to(() => PageConfirmationPart(part: listPart));
                  // if (_formKey.currentState!.validate()) {
                  // }
                },
                child: const Text('Salvar / Utilizar no orçamento'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUnitBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Unidade de medido do item',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _unidades.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_unidades[index]),
                      onTap: () {
                        setState(() {
                          _unitController.text = _unidades[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
