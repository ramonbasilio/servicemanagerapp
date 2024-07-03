import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class Signaturewidget extends StatefulWidget {
  final Function(List<dynamic>)? dataSign;
  const Signaturewidget({required this.dataSign, super.key});

  @override
  State<Signaturewidget> createState() => _SignaturewidgetState();
}

class _SignaturewidgetState extends State<Signaturewidget> {
  bool buttomControll = false;
  SignatureController controller = SignatureController(
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
                child: Text('Desfazer'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    controller.clear();
                  });
                  widget.dataSign!([]);
                  
                },
                child: Text('Apagar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttomControll ? Colors.green : null),
                onPressed: () async {
                  buttomControll = !buttomControll;
                  await controller.toPngBytes().then((data) {
                    if (data != null) {
                      widget.dataSign!(data);
                    }
                  }).then((_) {
                    setState(() {});
                  });
                },
                child: buttomControll ? Text('Ass. Gravada') : Text('Salvar'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
