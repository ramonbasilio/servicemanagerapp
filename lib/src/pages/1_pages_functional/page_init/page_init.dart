import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/pages/1_pages_functional/page_account/page_account.dart';
import 'package:servicemangerapp/src/pages/1_pages_functional/page_historic/page_historic.dart';
import 'package:servicemangerapp/src/pages/1_pages_functional/page_home/page_home.dart';

class PageInit extends StatefulWidget {
  const PageInit({super.key});

  @override
  State<PageInit> createState() => _PageInitState();
}

class _PageInitState extends State<PageInit> {
  ManagerProvider managerProvider = Get.put(ManagerProvider());

  final List<Widget> _pages = [
    const PageHome(),
    const PageHistoric(),
    const PageAccount(),
  ];
  int _index = 0;

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    managerProvider.getUserProfile();
    return Scaffold(
      drawer: Obx(() => Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        managerProvider.userProfile.value.name,
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      Text(
                        managerProvider.userProfile.value.email,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Histórico",
            icon: Icon(Icons.history),
          ),
          BottomNavigationBarItem(
            label: "Conta",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
