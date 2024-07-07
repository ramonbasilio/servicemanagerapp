import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:servicemangerapp/src/data/model/receiver_doc.dart';

class Firebasetorage extends GetxController {
  var getListImages = <String>[].obs;
  var getPathSign = ''.obs;
  final _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final String? emailUser;

  Firebasetorage() {
    emailUser = _firebaseAuth.currentUser!.email;
  }

  Future<void> uploadImage({
    required List<String> pathList,
    required List<int> signList,
    required ReceiverDoc receiverDoc,
  }) async {
    Uint8List uint8List = Uint8List.fromList(signList);
    List<String> listImages = [];
    String? pathSig;

    try {
      pathSig =
          '/$emailUser/${receiverDoc.client.id}/${receiverDoc.numberDoc}/sign/sign-${receiverDoc.client.name}.jpg';
      Reference myRef = _firebaseStorage.ref().child(pathSig);
      myRef.putData(uint8List);
      getPathSign.value = pathSig;
      print('salvou');
    } on FirebaseException catch (e) {
      print('Erro ao salvar imagem: $e');
    }

    for (var path in pathList) {
      if (path.isNotEmpty) {
        File file = File(path);
        String nameFile = path.split('/').last;
        try {
          Reference myRef = _firebaseStorage.ref().child(
              '/$emailUser/${receiverDoc.client.id}/${receiverDoc.numberDoc}/images/$nameFile');
          myRef.putFile(file);
          listImages.add(
              '/$emailUser/${receiverDoc.client.id}/${receiverDoc.numberDoc}/images/$nameFile');
          print('salvou');
        } on FirebaseException catch (e) {
          print('Erro ao salvar imagem: $e');
        }
      }
      getListImages.value = listImages;
    }
  }
}
