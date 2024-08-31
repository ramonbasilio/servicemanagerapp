// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class Part {
  String? idPart;
  String namePart;
  String detailsPart;
  String unitPart;
  int quantityPart;
  double pricePart;
  Part({
    required this.namePart,
    required this.quantityPart,
    required this.pricePart,
    required this.detailsPart,
    required this.unitPart,
    this.idPart,
  });

  factory Part.create({
    required String namePart,
    required int quantityPart,
    required double pricePart,
    required String detailsPart,
    required String unitPart,
  }) {
    String partId = const Uuid().v4();
    return Part(
        unitPart: unitPart,
        idPart: partId,
        namePart: namePart,
        detailsPart: detailsPart,
        quantityPart: quantityPart,
        pricePart: pricePart);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'namePart': namePart,
      'detailsPart': detailsPart,
      'unitPart': unitPart,
      'pricePart': pricePart,
      'quantityPart': quantityPart
    };
  }

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
        namePart: map['namePart'] as String,
        detailsPart: map['detailsPart'] ?? 'Sem notas',
        quantityPart: map['quantityPart'] as int,
        pricePart: map['pricePart'] as double,
        unitPart: map['unitPart'] as String,
        idPart: map['partId']);
  }

  String toJson() => json.encode(toMap());

  factory Part.fromJson(String source) =>
      Part.fromMap(json.decode(source) as Map<String, dynamic>);
}
