// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String name;
  final String description;
  final String category;
  final double price;
  final double? discount;
  final String imageUrl;
  final DateTime createdAt;

  ProductModel({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    this.discount,
    required this.imageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'discount': discount,
      'imageUrl': imageUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.empty() {
    return ProductModel(
      name: '',
      description: '',
      category: '',
      price: 0.0,
      imageUrl: '',
      createdAt: DateTime.now(),
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      price: map['price'] as double,
      discount: map['discount'] != null ? map['discount'] as double : null,
      imageUrl: map['imageUrl'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
