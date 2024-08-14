// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:uuid/uuid.dart';

class Part {
  String? partId;
  String partName;
  String partDetails;
  String partUnid;
  String partValue;
  Part({
    required this.partName,
    required this.partUnid,
    required this.partValue,
    required this.partDetails,
    this.partId,
  });

  factory Part.create({
    required String partName,
    required String partUnid,
    required String partValue,
    required String partDetails,
  }) {
    String partId = const Uuid().v4();
    return Part(
        partId: partId,
        partName: partName,
        partDetails: partDetails,
        partUnid: partUnid,
        partValue: partValue);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'partName': partName,
      'partDetails': partDetails,
      'partUnid': partUnid,
      'partValue': partValue,
    };
  }

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
        partName: map['partName'] as String,
        partDetails: map['partDetails'] ?? 'Sem notas',
        partUnid: map['partUnid'] as String,
        partValue: map['partValue'] as String,
        partId: map['partId']);
  }

  String toJson() => json.encode(toMap());

  factory Part.fromJson(String source) =>
      Part.fromMap(json.decode(source) as Map<String, dynamic>);
}
