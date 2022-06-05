
import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  int quantity = 0;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    this.quantity = 0,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  String getPriceFormat() {
    int quantityCurrent = (quantity == 0) ? 1 : quantity;
    double priceCurrent = price * quantityCurrent;
    return 'R\$ ${priceCurrent.toStringAsFixed(2)}';
  }

  incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  decrementQuantity() {
    if (quantity > 0) {
      quantity--;
      notifyListeners();
    }
  }
}
