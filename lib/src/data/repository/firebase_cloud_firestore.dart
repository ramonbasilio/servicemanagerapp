import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/alerts/alerts_dialog.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/model/receiver_doc.dart';
import 'package:servicemangerapp/src/pages/1_pages_functional/page_home/page_home.dart';

class FirebaseCloudFirestore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final String? emailUser;

  FirebaseCloudFirestore() {
    emailUser = _firebaseAuth.currentUser!.email;
  }

  Future<void> registerClient({required Client client}) async {
    await _firebaseFirestore
        .collection('User')
        .doc(emailUser)
        .collection('Clients')
        .doc(client.id)
        .set(client.toMap());
  }

  Future<List<Client>> getAllClients() async {
    List<Client> listClients = [];
    await _firebaseFirestore
        .collection('User')
        .doc(emailUser)
        .collection('Clients')
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        listClients.add(Client.fromMap(docSnapshot.data()));
      }
    });
    return listClients;
  }

  Future<void> updateClient({required Client client}) async {
    await _firebaseFirestore
        .collection('User')
        .doc(emailUser)
        .collection('Clients')
        .doc(client.id)
        .update(client.toMap());
  }

  Future<void> deleteClient({required String id}) async {
    await _firebaseFirestore
        .collection('User')
        .doc(emailUser)
        .collection('Clients')
        .doc(id)
        .delete();
  }

  Future<void> registerReceiverOrder(
      {required ReceiverDoc receiverDoc, required BuildContext context}) async {
    try {
      await _firebaseFirestore
          .collection('User')
          .doc(emailUser)
          .collection('Receiver Document')
          .doc(receiverDoc.numberDoc)
          .set(receiverDoc.toMap());
      if (context.mounted) {
        AlertsDialog.snackBarMessageFirebaseAuth(context,
            messageOpcional: 'Salvo com sucesso!',
            colorMessage: Colors.blueAccent);
      }

      Get.to(() => const PageHome());
    } on FirebaseException catch (_) {
      if (context.mounted) {
        AlertsDialog.snackBarMessageFirebaseAuth(context,
            messageOpcional: 'Falha ao salvar!', colorMessage: Colors.red);
      }
    }
  }
}
