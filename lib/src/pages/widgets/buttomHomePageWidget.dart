import 'package:flutter/material.dart';

class ButtomHomePageWidget extends StatefulWidget {
  void Function() func;
  String nameButtom;
  ButtomHomePageWidget({
    required this.func,
    required this.nameButtom,
    super.key,
  });

  @override
  State<ButtomHomePageWidget> createState() => _ButtomHomePageWidgetState();
}

class _ButtomHomePageWidgetState extends State<ButtomHomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.func,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.nameButtom,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blueGrey.shade700, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
// MELHORAR BOTÕES 
                // Container(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //           animationDuration: Duration(milliseconds: 30),
                //           shadowColor: Colors.white,
                //           foregroundColor: Colors.white,
                //           backgroundColor: Colors.grey),
                //       onPressed: () {},
                //       child: Text('Botão teste')),
                // ),