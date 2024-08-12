import 'package:flutter/material.dart';
import 'package:servicemangerapp/src/pages/3_part_list/list_part.dart';
import 'package:servicemangerapp/src/pages/3_part_list/register_part.dart';

class PagePart extends StatefulWidget {
  const PagePart({super.key});

  @override
  State<PagePart> createState() => _PagePartState();
}

class _PagePartState extends State<PagePart> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ListPart(),
    RegisterPart(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peças'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          BottomNavigationBar(
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            backgroundColor: Colors.grey.shade300,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: 'Lista de Peças',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: 'Cadastro',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
          Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
