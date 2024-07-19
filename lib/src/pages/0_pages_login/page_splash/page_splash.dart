import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:servicemangerapp/src/pages/0_pages_login/page_sign-in/page_sign-in.dart';
import 'package:servicemangerapp/src/pages/1_page_home/page_home.dart';

class PageSplash extends StatelessWidget {
  const PageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.idTokenChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PageHome();
        } else {
          return const PageSignIn();
        }
      },
    );
  }
}
