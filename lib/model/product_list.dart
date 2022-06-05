import 'dart:convert';
import 'dart:math';

import 'package:f6_ecommerce/data/dummy_data.dart';
import 'package:f6_ecommerce/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  // final _baseUrl = 'https://teste-db-d3d87-default-rtdb.firebaseio.com';
  final _baseUrl =
      'https://ecommerce-mini-projeto-04-default-rtdb.firebaseio.com';
  //img https://st.depositphotos.com/1000459/2436/i/950/depositphotos_24366251-stock-photo-soccer-ball.jpg

  final List<Product> _items = dummyProducts;
  final List<String> _idsCarrinho = [];
  bool _showFavoriteOnly = false;

  List<Product> get items {
    // get products of firebase
    http.get(Uri.parse(_baseUrl + '/products.json')).then((response) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Product> loadedProducts = [];
      data.forEach((id, prod) {
        loadedProducts.add(Product(
          id: id,
          title: prod['title'],
          description: prod['description'],
          price: prod['price'],
          imageUrl: prod['imageUrl'],
          isFavorite: prod['isFavorite'],
        ));
      });
      _items.clear();
      _items.addAll(loadedProducts);
      notifyListeners();
    });
    return [..._items];
  }

  List<String> get idsCarrinho {
    return [..._idsCarrinho];
  }

  double get total {
    double total = 0;
    for (var prod in carrinhoItems) {
      int quantityCurrent = prod.quantity == 0 ? 1 : prod.quantity;
      total += prod.price * quantityCurrent;
    }
    return total;
  }

  String getTotalFormat() {
    return "R\$ ${total.toStringAsFixed(2)}";
  }

  List<Product> get carrinhoItems {
    return _items
        .where((produto) => _idsCarrinho.contains(produto.id))
        .toList();
  }

  Product getProductById(String id) {
    return _items.firstWhere((produto) => produto.id == id);
  }

  void setIdCarrinhoAndListener(String id) {
    if (_idsCarrinho.contains(id)) {
      _idsCarrinho.remove(id);
      // return;
    } else {
      _idsCarrinho.add(id);
    }
    notifyListeners();
  }

  void setIdCarrinho(String id) {
    if (_idsCarrinho.contains(id)) {
      _idsCarrinho.remove(id);
    } else {
      _idsCarrinho.add(id);
    }
  }

  void removeIdCarrinho(String id) {
    _idsCarrinho.remove(id);
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) {
    final future = http.post(Uri.parse('$_baseUrl/products.json'),
        body: jsonEncode({
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        }));
    return future.then((response) {
      //print('espera a requisição acontecer');
      print(jsonDecode(response.body));
      final id = jsonDecode(response.body)['name'];
      print(response.statusCode);
      _items.add(Product(
          id: id,
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl));
      notifyListeners();
    });
    // print('executa em sequencia');
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['title'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }
  
  void updateProductList(Product product) {
    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _items[index] = product;
    }
    notifyListeners();
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      updateProductInFirebase(product).then((_) {
        notifyListeners();
      }).catchError((e) {
        print(e);
      });
    }
    return Future.value();
  }

  Future<void> updateProductInFirebase(Product product) {
    final url = '$_baseUrl/products/${product.id}.json';
    return http.patch(
      Uri.parse(url),
      body: jsonEncode({
        "title": product.title,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite,
      }),
    );
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      removeProductInFirebase(product).then((_) {
        notifyListeners();
      }).catchError((e) {
        print(e);
      });
    }
  }

  Future<void> removeProductInFirebase(Product product) {
    final url = '$_baseUrl/products/${product.id}.json';
    return http.delete(Uri.parse(url));
  }
}
