import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class Signaturewidget extends StatefulWidget {
  const Signaturewidget({super.key});

  @override
  State<Signaturewidget> createState() => _SignaturewidgetState();
}

class _SignaturewidgetState extends State<Signaturewidget> {
  SignatureController controller = SignatureController(
      onDrawEnd: () {
        print('desenhou...');
      },
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
                    controller.redo();
                  });
                },
                child: Text('Refazer'),
              ),
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
                },
                child: Text('Apagar'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
