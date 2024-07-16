import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/provider/provider.dart';
import 'package:signature/signature.dart';

class Signaturewidget extends StatefulWidget {
  final Function(List<int>)? dataSign;
  const Signaturewidget({required this.dataSign, super.key});

  @override
  State<Signaturewidget> createState() => _SignaturewidgetState();
}

class _SignaturewidgetState extends State<Signaturewidget> {
  bool buttomControll = false;
  SignatureController controller = SignatureController(
      onDrawEnd: () {},
      penStrokeWidth: 1,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyProvider value = Provider.of<MyProvider>(context, listen: false);
    return Column(
      children: [
        Signature(
          key: const Key('signature'),
          controller: controller,
          height: 300,
          backgroundColor: Colors.grey.shade300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    controller.undo();
                  });
                },
                child: const Text('Desfazer'),
              ),
              ElevatedButton(
                onPressed: () {
                  value.controllSign = false;
                  setState(() {
                    controller.clear();
                  });
                  widget.dataSign!([]);
                  if (controller.isNotEmpty) {
                    setState(() {
                      buttomControll = true;
                    });
                  } else {
                    setState(() {
                      buttomControll = false;
                    });
                  }
                },
                child: const Text('Apagar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
                onPressed: () async {
                  value.controllSign = true;
                  if (controller.isNotEmpty) {
                    await controller.toPngBytes().then((data) {
                      if (data != null) {
                        widget.dataSign!(data);
                      }
                    });
                  }
                },
                child: const Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
