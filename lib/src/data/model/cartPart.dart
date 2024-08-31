import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CartPart {
  String name;
  RxInt quantity;
  double price;
  int index;

  CartPart(
      {required this.name,
      required int quantity,
      required this.index,
      required this.price})
      : quantity = quantity.obs;
}
