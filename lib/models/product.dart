import 'package:flutter/material.dart';

class ValidateAttribute {
  final String attribute;
  final String message;

  ValidateAttribute(this.attribute, this.message);
}

class Product with ChangeNotifier {
  String id;
  String name;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  static Product init() {
    return Product(id: '', name: '', description: '', price: 0.0, imageUrl: '');
  }

  static String? validName(String name) {
    if (name.isEmpty) {
      return 'O nome está vazio.';
    }
    return null;
  }

  static String? validDescription(String description) {
    if (description.isEmpty) {
      return 'A descrição está vazia.';
    }
    return null;
  }

  static String? validPrice(double price) {
    if (price < 0.00) {
      return 'Preço está negativo.';
    }
    return null;
  }

  static String? validImageUrl(String imageUrl) {
    if (imageUrl.isEmpty) {
      return 'A url da imagem está vazia.';
    }
    return null;
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
