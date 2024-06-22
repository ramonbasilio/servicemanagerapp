// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/client_model.dart';
import 'package:servicemangerapp/src/data/repository/firebase_repository.dart';

class ClientsProvider extends GetxController {
  var isLoading = true.obs;
  var allClients = <ClientModel>[].obs;
  var foundClients = <ClientModel>[].obs;

  FirebaseRepository _firebaseRepository = FirebaseRepository();
  
  

  @override
  void onInit() {
    getAllClientsProvider();
    print('ponto A)');
    super.onInit();
  }

  Future<void> getAllClientsProvider() async {
    print('ponto B)');
    allClients.value = [];
    List<ClientModel> response = await _firebaseRepository.getAllClients();
    response.sort((a, b) => a.name.compareTo(b.name));
    for (var x in response) {
      allClients.add(x);
    }
    foundClients.value = allClients;
  }

  Future<void> registerClientProvider({required ClientModel client}) async {
    await _firebaseRepository.registerClient(client: client);
    getAllClientsProvider();
  }

  Future<void> updateClientProvider({required ClientModel client}) async {
    await _firebaseRepository.updateClient(client: client);
    getAllClientsProvider();
  }

  Future<void> deleteProvider({required String id}) async {
    await _firebaseRepository.deleteClient(id: id);
    getAllClientsProvider();
  }

  Future<void> searchClient({required String name}) async {
    List<ClientModel> result = [];
    if (name.isEmpty) {
      result = allClients;
    } else {
      result = allClients
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(name.toLowerCase()))
          .toList();
    }
    foundClients.value = result;
  }
}
