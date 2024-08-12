import 'package:flutter/material.dart';

class ListPart extends StatefulWidget {
  const ListPart({super.key});

  @override
  State<ListPart> createState() => _ListPartState();
}

class _ListPartState extends State<ListPart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Lista de peças')),
    );
  }
}