import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/client_model.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';

class FirebaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> registerClient({required ClientModel client}) async {
    await _firebaseFirestore
        .collection('Clients')
        .doc(client.id)
        .set(client.toMap());

  }

  Future<List<ClientModel>> getAllClients() async {
    List<ClientModel> listClients = [];
    await _firebaseFirestore.collection('Clients').get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        listClients.add(ClientModel.fromMap(docSnapshot.data()));
      }
    });
    return listClients;
  }

    Future<void> updateClient({required ClientModel client}) async {
    await _firebaseFirestore
        .collection('Clients')
        .doc(client.id)
        .update(client.toMap());
  }

      Future<void> deleteClient({required String id}) async {
    await _firebaseFirestore
        .collection('Clients')
        .doc(id)
        .delete();
  }

  
}
