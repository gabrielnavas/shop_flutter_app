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
    name = name.trim();
    if (name.isEmpty) {
      return 'O nome está vazio.';
    }
    if (name.length < 2) {
      return 'O nome deve ser maior que 2 caracteres.';
    }
    if (name.length > 30) {
      return 'O nome deve ser menor que 30 caracteres.';
    }
    return null;
  }

  static String? validDescription(String description) {
    description = description.trim();
    if (description.isEmpty) {
      return 'A descrição está vazia.';
    }

    if (description.length < 6) {
      return 'A descrição deve ser maior que 6 caracteres.';
    }

    if (description.length > 120) {
      return 'A descrição deve ser menor que 120 caracteres.';
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
    imageUrl = imageUrl.trim();
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
