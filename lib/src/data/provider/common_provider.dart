import 'package:get/get.dart';
import 'package:servicemangerapp/src/data/model/part.dart';

class CommonProvider extends GetxController {
  var finalPriceParts = 0.0.obs;
  var part = <Part>[].obs;
  List temp = [];

  // void getFinalPriceParts() {
  //   List<double> temp = [];
  //   part.forEach((e) {
  //     temp.add(double.parse(e.valuePart));
  //   });
  //   print('Lista de valores: $temp');
  //   double result = 0.0;
  //   for (var i = 0; i < part.length; i++) {
  //     result = result + double.parse(finalPriceParts[i] * temp[i]);
  //   }
  //   print('Valor total das peças ${result.toString()}');
  // }

  void getFinalPriceParts({double? value, int? newIndex, double? newValue}) {
    if (value != null) {
      temp.add(value);
      print('valor da lista $temp');
    }
    if (newIndex != null) {
      temp[newIndex] = newValue;
      print('valor da lista atualizada $temp');
    }
    finalPriceParts.value = temp.reduce((a, b) => a + b);
    print('Preço final: ${finalPriceParts.value}');
  }
}
