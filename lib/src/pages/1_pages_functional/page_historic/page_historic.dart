import 'package:flutter/material.dart';

class PageHistoric extends StatelessWidget {
  const PageHistoric({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Histórico'),
      ),
    );
  }
}
