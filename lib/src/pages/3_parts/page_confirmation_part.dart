import 'package:flutter/material.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/pages/widgets/cart_confirmation_part_widget.dart';

class PageConfirmationPart extends StatefulWidget {
  List<Part> part;
  PageConfirmationPart({required this.part, super.key});

  @override
  State<PageConfirmationPart> createState() => _PageConfirmationPartState();
}

class _PageConfirmationPartState extends State<PageConfirmationPart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peças do Orçamento'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: widget.part.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CartConfirmationPartWidget(
                        part: widget.part[index], index: index),
                    const Divider()
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
