import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/3_parts/page_confirmation_part.dart';

class PageListPart extends StatefulWidget {
  const PageListPart({super.key});

  @override
  State<PageListPart> createState() => _PageListPartState();
}

class _PageListPartState extends State<PageListPart> {
  ManagerProvider clientController = Get.put(ManagerProvider());
  List<Part> selectedParts = [];
  List<Part> parts = [];

  @override
  void initState() {
    parts = clientController.allParts;
    clientController.getAllPartsProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Flexible(
              child: ListView.builder(
                itemCount: parts.length,
                itemBuilder: (context, index) {
                  final item = parts[index];
                  final isSelected = selectedParts.contains(item);
                  return Column(
                    children: [
                      ListTile(
                        onLongPress: (() {
                          _showDetailPart(context, parts[index]);
                        }),
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedParts.remove(parts[index]);
                              } else {
                                selectedParts.add(parts[index]);
                              }
                            });
                          },
                          child: Icon(
                            isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),
                        ),
                        title: Text(parts[index].namePart),
                      ),
                      const Divider()
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade100),
            onPressed: () {
              Get.to(() => PageConfirmationPart(part: selectedParts));
              // if (_formKey.currentState!.validate()) {
              // }
            },
            child: const Text('Utilizar no orçamento'),
          ),
        ),
      ),
    );
  }

  void _showDetailPart(BuildContext context, Part part) {
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
                  'Detalhes do item',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Text('Nome da peça: ${part.namePart}'),
              Text('Detalhes: ${part.detailsPart}'),
              Text('Unidade de medida: ${part.unidPart}'),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Editar'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Apagar'),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
