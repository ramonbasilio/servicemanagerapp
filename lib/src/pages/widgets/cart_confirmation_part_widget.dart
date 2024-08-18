import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:vibration/vibration.dart';

class CartConfirmationPartWidget extends StatefulWidget {
  Part part;
  int index;
  final Function(Part) removePartFromList;
  final Function(String) finalPrice;
  CartConfirmationPartWidget({
    required this.finalPrice,
    required this.part,
    required this.index,
    required this.removePartFromList,
    super.key,
  });

  @override
  State<CartConfirmationPartWidget> createState() =>
      _CartConfirmationPartWidgetState();
}

class _CartConfirmationPartWidgetState
    extends State<CartConfirmationPartWidget> {
  double valuePartFinal = 0.0;
  int amount = 1;
  bool controlRemoveItem = false;

  @override
  void initState() {
    valuePartFinal = double.parse(widget.part.valuePart.replaceAll(',', '.'));
    super.initState();
  }

  void increaseValue() {
    setState(() {
      amount = amount + 1;
      if (amount >= 1) {
        setState(() {
          controlRemoveItem = false;
        });
        //widget.removePartFromList(part);
      }

      valuePartFinal =
          double.parse(widget.part.valuePart.replaceAll(',', '.')) * amount;
      widget.finalPrice(valuePartFinal.toString());
    });
  }

  void decreaseValue(Part part) {
    amount = amount - 1;
    if (amount == 0) {
      setState(() {
        controlRemoveItem = true;
      });
    }
    if (amount <= 0) {
      setState(() {
        valuePartFinal = 0.0;
        amount = 0;
      });
      //widget.removePartFromList(part);
    }
    setState(() {
      valuePartFinal =
          double.parse(widget.part.valuePart.replaceAll(',', '.')) * amount;
    });
  }

  ManagerProvider clientController = Get.put(ManagerProvider());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: ListTile(
        tileColor: controlRemoveItem
            ? const Color.fromARGB(255, 253, 222, 225)
            : Color.fromARGB(255, 239, 250, 239),
        leading: Text(
          widget.index.toString(),
        ),
        title: Text(widget.part.namePart),
        subtitle: Text(
          'R\$: ${valuePartFinal.toString()}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: SizedBox(
          height: 150,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Vibration.vibrate(duration: 50);
                        decreaseValue(widget.part);
                      },
                      icon: const Icon(Icons.remove)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '$amount',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Vibration.vibrate(duration: 100);
                        increaseValue();
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
