import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servicemangerapp/src/data/model/client_model.dart';

class FirebaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final String idUser;

  FirebaseRepository() {
    idUser = _firebaseAuth.currentUser!.uid;
  }

  Future<void> registerClient({required ClientModel client}) async {
    await _firebaseFirestore
        .collection('User')
        .doc(idUser)
        .collection('Clients')
        .doc(client.id)
        .set(client.toMap());
  }

  Future<List<ClientModel>> getAllClients() async {
    List<ClientModel> listClients = [];
    await _firebaseFirestore
        .collection('User')
        .doc(idUser)
        .collection('Clients')
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        listClients.add(ClientModel.fromMap(docSnapshot.data()));
      }
    });
    return listClients;
  }

  Future<void> updateClient({required ClientModel client}) async {
    await _firebaseFirestore
        .collection('User')
        .doc(idUser)
        .collection('Clients')
        .doc(client.id)
        .update(client.toMap());
  }

  Future<void> deleteClient({required String id}) async {
    await _firebaseFirestore
        .collection('User')
        .doc(idUser)
        .collection('Clients')
        .doc(id)
        .delete();
  }
}
