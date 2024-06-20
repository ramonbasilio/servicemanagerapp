import 'dart:convert';

import 'package:uuid/uuid.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClientModel {
  final String name;
  final String phone;
  final String email;
  final String? notes;
  final String? id;

  ClientModel({
    required this.name,
    required this.phone,
    required this.email,
    this.notes,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'email': email,
      'notes': notes,
      'id': id,
    };
  }

  factory ClientModel.crate({
    required String name,
    required String phone,
    required String email,
    String? notes,
  }) {
    String id = const Uuid().v4();
    return ClientModel(
      name: name,
      phone: phone,
      email: email,
      id: id,
      notes: notes ?? '',
    );
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      notes: map['notes'] ?? 'Sem notas',
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
