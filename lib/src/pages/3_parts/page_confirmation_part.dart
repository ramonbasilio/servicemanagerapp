import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/data/provider/common_provider.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/3_parts/page_part.dart';
import 'package:servicemangerapp/src/pages/widgets/cart_confirmation_part_widget.dart';

class PageConfirmationPart extends StatefulWidget {
  List<Part> part;
  PageConfirmationPart({required this.part, super.key});

  @override
  State<PageConfirmationPart> createState() => _PageConfirmationPartState();
}

class _PageConfirmationPartState extends State<PageConfirmationPart> {
  List<String> valuesPrices = [];
  CommonProvider myProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peças do Orçamento'),
        leading: IconButton(
          icon: Icon(Icons.abc),
          onPressed: () {
            // Ação quando o botão de votar for pressionado
            Get.off(() => PagePart());
            // Você pode adicionar aqui a lógica de votação
          },
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: widget.part.isEmpty
                ? const Text('Sem itens')
                : ListView.builder(
                    itemCount: widget.part.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CartConfirmationPartWidget(
                                part: widget.part[index], index: index),
                          ),
                          //const Divider()
                        ],
                      );
                    },
                  ),
          ),
          Obx(() => Text('Valor das peças: R\$: ${myProvider.finalPriceParts.value}'),)
        ],
      ),
      // bottomNavigationBar: Obx(() => SizedBox(
      //         height: 100,
      //         child: Text('Valor das peças: R\$: ${myProvider.finalPriceParts.value}'),
      //       )),
    );
  }
}
