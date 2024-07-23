import 'dart:math';

class Utils {
  static int gerenateNumerServiceOrder() {
    int min = 10000;
    int max = 99999;
    return min + Random().nextInt((max + 1) - min);
  }

  static String convertDate(DateTime detetime){
    return  "${detetime.day.toString().padLeft(2, '0')}/${detetime.month.toString().padLeft(2, '0')}/${detetime.year}";

  }
}
