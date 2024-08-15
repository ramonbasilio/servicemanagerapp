import 'package:flutter/material.dart';
import 'package:servicemangerapp/src/data/model/part.dart';

class CartConfirmationPartWidget extends StatefulWidget {
  Part part;
  int index;
  CartConfirmationPartWidget({
    required this.part,
    required this.index,
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

  @override
  void initState() {
    valuePartFinal = double.parse(widget.part.valuePart.replaceAll(',', '.'));
    super.initState();
  }

  void increaseValue() {
    setState(() {
      amount = amount + 1;
      valuePartFinal =
          double.parse(widget.part.valuePart.replaceAll(',', '.')) * amount;
    });
  }

  void decreaseValue() {
    setState(() {
      amount = amount - 1;
      if (valuePartFinal == 0.0) {
        valuePartFinal = 0.0;
        amount = 0;
      } else {
        valuePartFinal =
            double.parse(widget.part.valuePart.replaceAll(',', '.')) * amount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        widget.index.toString(),
      ),
      title: Text(widget.part.namePart),
      subtitle: Text('R\$: ${valuePartFinal.toString()}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                decreaseValue();
              },
              icon: const Icon(Icons.remove)),
          Text('Quantidade: $amount'),
          IconButton(
              onPressed: () {
                increaseValue();
              },
              icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
