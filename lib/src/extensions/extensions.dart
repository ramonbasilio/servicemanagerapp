import 'package:flutter/material.dart';

extension TimeOfDayConverter on DateTime {
 String dateTimeFormart() {
    return "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";
  }
}