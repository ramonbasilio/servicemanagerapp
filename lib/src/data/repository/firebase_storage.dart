import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemangerapp/src/data/model/receiver_doc.dart';
import 'package:servicemangerapp/src/data/provider/provider.dart';

class Firebasetorage {
  final _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final String? _emailUser;

  String urlString = '';
  List<String> listString = [];

  Firebasetorage() {
    _emailUser = _firebaseAuth.currentUser!.email;
  }

  Future<void> uploadImage(
      {required List<String> pathList,
      required List<int> signList,
      required String clientId,
      required String numberDoc,
      required String clientName,
      required BuildContext context}) async {
    Uint8List uint8List = Uint8List.fromList(signList);

    if (context.mounted) {
      MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);

      try {
        Reference myRef = _firebaseStorage.ref().child(
            '/$_emailUser/$clientId/$numberDoc/sign/sign-$clientName.jpg');
        await myRef.putData(uint8List);
        urlString = await myRef.getDownloadURL();
      } on FirebaseException catch (e) {
        print('Erro ao salvar assinatura: $e');
      }
      pathList.forEach((x) {
        print('imprindo cada elemento dentro da class: $x');
      });
      for (var path in pathList) {
        if (path.isEmpty) {
          listString.add('');
        } else {
          File file = File(path);
          String nameFile = path.split('/').last;
          try {
            Reference myRef = _firebaseStorage
                .ref()
                .child('/$_emailUser/$clientId/$numberDoc/images/$nameFile');
            await myRef.putFile(file);
            String temp = await myRef.getDownloadURL();
            listString.add(temp);
          } on FirebaseException catch (e) {
            print('Erro ao salvar imagens: $e');
          }
        }
      }
      myProvider.addPathList(listString, urlString);
    }
  }
}
