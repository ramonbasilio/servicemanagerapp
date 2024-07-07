import 'dart:math';

class Utils {
  static int gerenateNumerServiceOrder() {
    int min = 10000;
    int max = 99999;
    return min + Random().nextInt((max + 1) - min);
  }
}
