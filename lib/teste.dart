import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  const Teste({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.green.shade100,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(10))),
                onPressed: () {},
                child: Text('Botão 1'),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Botão 1'),
            ),
          ],
        ),
      ),
    );
  }
}
