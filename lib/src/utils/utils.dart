import 'dart:math';

import 'package:get/get.dart';

class Utils {
  static int gerenateNumerServiceOrder() {
    int min = 10000;
    int max = 99999;
    return min + Random().nextInt((max + 1) - min);
  }

  static String convertDate(DateTime datetime) {
    return "${datetime.day.toString().padLeft(2, '0')}/${datetime.month.toString().padLeft(2, '0')}/${datetime.year} - ${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}";
  }
}
