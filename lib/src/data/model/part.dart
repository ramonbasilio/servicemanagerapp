// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class Part {
  String? idPart;
  String namePart;
  String detailsPart;
  String unidPart;
  String valuePart;
  Part({
    required this.namePart,
    required this.unidPart,
    required this.valuePart,
    required this.detailsPart,
    this.idPart,
  });

  factory Part.create({
    required String partName,
    required String partUnid,
    required String partValue,
    required String partDetails,
  }) {
    String partId = const Uuid().v4();
    return Part(
        idPart: partId,
        namePart: partName,
        detailsPart: partDetails,
        unidPart: partUnid,
        valuePart: partValue);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'partName': namePart,
      'partDetails': detailsPart,
      'partUnid': unidPart,
      'partValue': valuePart,
    };
  }

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
        namePart: map['partName'] as String,
        detailsPart: map['partDetails'] ?? 'Sem notas',
        unidPart: map['partUnid'] as String,
        valuePart: map['partValue'] as String,
        idPart: map['partId']);
  }

  String toJson() => json.encode(toMap());

  factory Part.fromJson(String source) =>
      Part.fromMap(json.decode(source) as Map<String, dynamic>);
}
