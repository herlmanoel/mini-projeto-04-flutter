import 'package:f6_ecommerce/model/product.dart';
import 'package:f6_ecommerce/model/product_list.dart';
import 'package:flutter/cupertino.dart';

class Carrinho extends ChangeNotifier {
  List<String> idsItems = [];

  void addItem(String id) {
    idsItems.add(id);
    notifyListeners();
  }

  void removeItem(String id) {
    idsItems.remove(id);
    notifyListeners();
  }

  int get totalItens {
    return idsItems.length;
  }

  double get total {
    double total = 0;
    for (String id in idsItems) {
      total += ProductList().items.firstWhere((p) => p.id == id).price;
    }
    return total;
  }
}