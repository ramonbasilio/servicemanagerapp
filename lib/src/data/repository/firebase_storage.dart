import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:servicemangerapp/src/data/model/receiver_doc.dart';

class Firebasetorage extends ChangeNotifier {
  String _urlDownloadSign = '';
  String get urlDownloadSign => _urlDownloadSign;

  final List<String> _listFileImage = [];
  List<String> get listFileImage => _listFileImage;

  final _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final String? _emailUser;

  Firebasetorage() {
    _emailUser = _firebaseAuth.currentUser!.email;
  }

  Future<void> uploadImage(
      {required List<String> pathList,
      required List<int> signList,
      required String clientId,
      required String numberDoc,
      required String clientName}) async {
    Uint8List uint8List = Uint8List.fromList(signList);

    try {
      Reference myRef = _firebaseStorage
          .ref()
          .child('/$_emailUser/$clientId/$numberDoc/sign/sign-$clientName.jpg');
      await myRef.putData(uint8List);
      _urlDownloadSign = await myRef.getDownloadURL();
      print('URL: $_urlDownloadSign');
      notifyListeners();
    } on FirebaseException catch (e) {
      print('Erro ao salvar assinatura: $e');
    }
    notifyListeners();

    for (var path in pathList) {
      if (path.isNotEmpty) {
        File file = File(path);
        String nameFile = path.split('/').last;
        try {
          Reference myRef = _firebaseStorage
              .ref()
              .child('/$_emailUser/$clientId/$numberDoc/images/$nameFile');
          await myRef.putFile(file);
          String temp = await myRef.getDownloadURL();
          _listFileImage.add(temp);
          _listFileImage.forEach((x) {
            print(x);
          });
          notifyListeners();
        } on FirebaseException catch (e) {
          print('Erro ao salvar imagens: $e');
        }
        notifyListeners();
      }
    }
    notifyListeners();
  }
}
