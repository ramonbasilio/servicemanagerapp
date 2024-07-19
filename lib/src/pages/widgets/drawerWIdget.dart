import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';
import 'package:servicemangerapp/src/data/repository/firebase_auth.dart';
import 'package:servicemangerapp/src/pages/0_pages_login/page_sign-in/page_sign-in.dart';

class Drawerwidget extends StatelessWidget {
  ManagerProvider managerProvider;
  Drawerwidget({required this.managerProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    managerProvider.userProfile.value.name,
                    style: const TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  Text(
                    managerProvider.userProfile.value.email,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
                // Navegue para a página inicial, se necessário
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                // Navegue para a página de configurações, se necessário
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Sair'),
              onTap: () async {
                  await FireAuth.signOut(context: context);
                  Get.to(() => const PageSignIn());
                },
            ),
          ],
        ),
      ),
    );
  }
}
