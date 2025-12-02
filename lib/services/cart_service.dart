import 'package:flutter/foundation.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => List.unmodifiable(_cartItems);

  int get itemCount => _cartItems.length;

  void addToCart({
    required String title,
    required String price,
    required String imageUrl,
    required int quantity,
    String? color,
    String? size,
  }) {
    _cartItems.add({
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'color': color,
      'size': size,
    });
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _cartItems.length && newQuantity > 0) {
      _cartItems[index]['quantity'] = newQuantity;
      notifyListeners();
    }
  }

  void clear() {
    _cartItems.clear();
    notifyListeners();
  }

  double calculateSubtotal() {
    double subtotal = 0;
    for (var item in _cartItems) {
      final priceString = item['price'].toString().replaceAll('£', '');
      final price = double.tryParse(priceString) ?? 0;
      final quantity = item['quantity'] ?? 1;
      subtotal += price * quantity;
    }
    return subtotal;
  }
}
