import 'package:flutter/material.dart';

class ButtomHomePageWidget2 extends StatelessWidget {
  void Function() func;
  String nameButtom;
  ButtomHomePageWidget2({
    required this.func,
    required this.nameButtom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: func,
        child: Text(
          nameButtom,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withAlpha(200),
              fontSize: 25),
        ),
      ),
    );
  }
}
