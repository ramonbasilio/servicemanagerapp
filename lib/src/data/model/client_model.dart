import 'dart:convert';

import 'package:uuid/uuid.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Client {
  final String name;
  final String phone;
  final String email;
  final String? notes;
  final String? id;

  Client({
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

  factory Client.crate({
    required String name,
    required String phone,
    required String email,
    String? notes,
  }) {
    String id = const Uuid().v4();
    return Client(
      name: name,
      phone: phone,
      email: email,
      id: id,
      notes: notes ?? '',
    );
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      notes: map['notes'] ?? 'Sem notas',
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Client.fromJson(String source) =>
      Client.fromMap(json.decode(source) as Map<String, dynamic>);
}
