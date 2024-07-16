import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:servicemangerapp/src/data/model/client.dart';

class ServiceOrder {
  Client client;
  String numberDoc;
  String equipment;
  String brand;
  String model;
  String accessories;
  String defect;
  List<String> pathImages;
  String pathSign;
  DateTime? date;
  ServiceOrder(
      {required this.client,
      required this.numberDoc,
      required this.equipment,
      required this.brand,
      required this.model,
      required this.accessories,
      required this.defect,
      required this.pathImages,
      required this.pathSign,
      DateTime? date})
      : date = DateTime.now();

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'client': client.toMap()});
    result.addAll({'numberServiceOrder': numberDoc});
    result.addAll({'equipment': equipment});
    result.addAll({'brand': brand});
    result.addAll({'model': model});
    result.addAll({'accessories': accessories});
    result.addAll({'defect': defect});
    result.addAll({'pathImages': pathImages});
    result.addAll({'pathSign': pathSign});
    result.addAll({'date': date.toString()});
    return result;
  }

  factory ServiceOrder.fromMap(Map<String, dynamic> map) {
    return ServiceOrder(
        client: Client.fromMap(map['client'] as Map<String, dynamic>),
        numberDoc: map['numberServiceOrder'],
        equipment: map['equipment'],
        brand: map['brand'],
        model: map['model'],
        accessories: map['accessories'],
        defect: map['defect'],
        pathImages: List<String>.from(map['pathImages']),
        pathSign: map['pathSign'],
        date: DateTime.parse(map['date']));
  }

  String toJson() => json.encode(toMap());

  factory ServiceOrder.fromJson(String source) =>
      ServiceOrder.fromMap(json.decode(source));
}
