// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoriaModel {
  final String id;
  final String name;

  CategoriaModel({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CategoriaModel.fromMap(Map<String, dynamic> map) {
    return CategoriaModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriaModel.fromJson(String source) => CategoriaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
