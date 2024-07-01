import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servicemangerapp/src/data/model/client_model.dart';

class FirebaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final String? emailUser;

  FirebaseRepository() {
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
}
