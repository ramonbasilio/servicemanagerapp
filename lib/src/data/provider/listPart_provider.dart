import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/cartPart.dart';
import 'package:servicemangerapp/src/data/model/part.dart';

class ListPartController extends GetxController {
  var partItemsList = <CartPart>[].obs;
  var totalPrice = 0.0.obs;

  

  void addItem(CartPart part) {
    partItemsList.add(part);
    updatePriceTotal();
  }

  void removeItem(CartPart part) {
    partItemsList.remove(part);
    updatePriceTotal();
  }

  void updateItemQuantity(CartPart part, int quantity) {
    int index =
        partItemsList.indexWhere((element) => element.index == part.index);
    if (index != -1) {
      partItemsList[index].quantity.value = quantity;
      updatePriceTotal();
    }
  }

  void updatePriceTotal() {
    totalPrice.value = partItemsList.fold(
        0, (sum, item) => sum + (item.price * item.quantity.value));
  }
}
