// ignore_for_file: prefer_final_fields
import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/client.dart';
import 'package:servicemangerapp/src/data/model/service_order.dart';
import 'package:servicemangerapp/src/data/model/user.dart';
import 'package:servicemangerapp/src/data/repository/firebase_cloud_firestore.dart';

class ManagerProvider extends GetxController {
  var controlAddClientPage = false.obs;
  var foundClients = <Client>[].obs;
  var allServiceOrder = <ServiceOrder>[].obs;
  Rx<UserProfile> userProfile = UserProfile(
    email: '',
    idUser: '',
    name: '',
  ).obs;

  FirebaseCloudFirestore _firebaseRepository = FirebaseCloudFirestore();

  Future<void> reloadProvider() async {
    await getAllClientsProvider();
    await getAllServiceOrderProvider();
    await getUserProfile();
  }

  Future<void> getAllClientsProvider() async {
    print('chamou getAllClientsProvider');
    List<Client> response = await _firebaseRepository.getAllClients();
    response.sort((a, b) => a.name.compareTo(b.name));
    foundClients.value = response;
  }

  void updateUserProfile(UserProfile newUserProfile) {
    userProfile.value = newUserProfile;
  }

  Future<void> getUserProfile() async {
    print('chamou getUserProfile');
    UserProfile? _userProfile = await FirebaseCloudFirestore().getUserProfile();
    if (_userProfile != null) {
      updateUserProfile(_userProfile);
    }
  }

  Future<void> registerClientProvider({required Client client}) async {
    await _firebaseRepository.registerClient(client: client);
    getAllClientsProvider();
  }

  Future<void> updateClientProvider({required Client client}) async {
    await _firebaseRepository.updateClient(client: client);
    getAllClientsProvider();
  }

  Future<void> deleteProvider({required String id}) async {
    await _firebaseRepository.deleteClient(id: id);
    getAllClientsProvider();
  }

  Future<void> deleteProviderMethod(
      {required String colletion, required String id}) async {
    await _firebaseRepository.deleteMethod(colletion: colletion, id: id);
    getAllServiceOrderProvider();
  }

  Future<void> searchClient({required String name}) async {
    List<Client> result = [];
    result = foundClients
        .where((element) =>
            element.name.toString().toLowerCase().contains(name.toLowerCase()))
        .toList();
    foundClients.value = result;
    if (name.isEmpty) {
      await getAllClientsProvider(); // PRECISO ARRUMAR ISSO.
    }
  }

  Future<void> getAllServiceOrderProvider() async {
    print('chamou getAllServiceOrderProvider');
    List<ServiceOrder>? response =
        await _firebaseRepository.getAllServiceOrders();
    response!.sort((a, b) => b.date!.compareTo(a.date!));
    allServiceOrder.value = response;
  }
}
