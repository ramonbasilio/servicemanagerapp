import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/provider/provider.dart';
import 'package:servicemangerapp/src/data/repository/firebase_storage.dart';
import 'package:servicemangerapp/src/pages/0_pages_login/page_splash/page_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:servicemangerapp/src/pages/2_pages_buttom/page_quotation/page_quotation.dart';
import 'package:servicemangerapp/src/pages/3_part_list/page_part.dart';
import 'package:servicemangerapp/src/pages/widgets/camera_widget_2.dart';
import 'package:servicemangerapp/teste.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Service Manager App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PagePart(),
    );
  }
}
