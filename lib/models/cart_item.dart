import 'package:uuid/uuid.dart';

class CartItem {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double productPrice;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.productPrice,
  });

  static CartItem create(
    String productId,
    String productName,
    int quantity,
    double productPrice,
  ) {
    return CartItem(
      id: const Uuid().v4(),
      productId: productId,
      productName: productName,
      quantity: quantity,
      productPrice: productPrice,
    );
  }
}
