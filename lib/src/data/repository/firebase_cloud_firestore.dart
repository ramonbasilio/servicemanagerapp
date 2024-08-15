import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/alerts/alerts_dialog.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/model/part.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:servicemangerapp/src/data/model/user.dart';
import 'package:servicemangerapp/src/pages/0_pages_login/page_splash/page_splash.dart';

class FirebaseCloudFirestore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerClient({required Client client}) async {
    await _firebaseFirestore
        .collection('User')
        .doc(_firebaseAuth.currentUser!.email)
        .collection('Clients')
        .doc(client.id)
        .set(client.toMap());
  }

  Future<void> registerUserProfile({required UserProfile user}) async {
    await _firebaseFirestore
        .collection('User')
        .doc(_firebaseAuth.currentUser!.email)
        .set(user.toMap());
  }

  Future<UserProfile?> getUserProfile() async {
    DocumentSnapshot docSnapshot = await _firebaseFirestore
        .collection('User')
        .doc(_firebaseAuth.currentUser!.email)
        .get();
    if (docSnapshot.exists) {
      return UserProfile.fromMap(docSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<List<Client>> getAllClients() async {
    List<Client> listClients = [];
    await _firebaseFirestore
        .collection('User')
        .doc(_firebaseAuth.currentUser!.email)
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
        .doc(_firebaseAuth.currentUser!.email)
        .collection('Clients')
        .doc(client.id)
        .update(client.toMap());
  }

  Future<void> deleteClient({required String id}) async {
    await _firebaseFirestore
        .collection('User')
        .doc(_firebaseAuth.currentUser!.email)
        .collection('Clients')
        .doc(id)
        .delete();
  }

  Future<void> deleteMethod(
      {required String colletion, required String id}) async {
    await _firebaseFirestore
        .collection('User')
        .doc(_firebaseAuth.currentUser!.email)
        .collection(colletion)
        .doc(id)
        .delete();
  }

  Future<void> registerReceiverOrder(
      {required ServiceOrder receiverDoc,
      required BuildContext context}) async {
    try {
      await _firebaseFirestore
          .collection('User')
          .doc(_firebaseAuth.currentUser!.email)
          .collection('Service Order')
          .doc(receiverDoc.numberDoc)
          .set(receiverDoc.toMap());
      if (context.mounted) {
        AlertsDialog.snackBarMessageFirebaseAuth(context,
            messageOpcional: 'Salvo com sucesso!',
            colorMessage: Colors.blueAccent);
      }

      Get.off(() => const PageSplash());
    } on FirebaseException catch (_) {
      if (context.mounted) {
        AlertsDialog.snackBarMessageFirebaseAuth(context,
            messageOpcional: 'Falha ao salvar!', colorMessage: Colors.red);
      }
    }
  }

  Future<List<ServiceOrder>?> getAllServiceOrders() async {
    List<ServiceOrder> listServiceOrder = [];
    try {
      await _firebaseFirestore
          .collection('User')
          .doc(_firebaseAuth.currentUser!.email)
          .collection('Service Order')
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          listServiceOrder.add(ServiceOrder.fromMap(docSnapshot.data()));
        }
      });
      return listServiceOrder;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> registerPart({required Part part}) async {
    await _firebaseFirestore
        .collection('User')
        .doc('graziellacsousa@gmail.com')
        .collection('Parts')
        .doc(part.idPart)
        .set(part.toMap());
  }

    Future<List<Part>?> getAllParts() async {
    List<Part> listParts = [];
    try {
      await _firebaseFirestore
          .collection('User')
          .doc('graziellacsousa@gmail.com')
          .collection('Parts')
          .get()
          .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          listParts.add(Part.fromMap(docSnapshot.data()));
        }
      });
      return listParts;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
}
