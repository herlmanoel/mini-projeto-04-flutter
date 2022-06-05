import 'package:f6_ecommerce/components/product_item.dart';
import 'package:f6_ecommerce/model/options.dart';
import 'package:f6_ecommerce/model/product.dart';
import 'package:f6_ecommerce/model/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final Options _showOnlyFavoritos;
  const ProductGrid(this._showOnlyFavoritos);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    List<Product> loadedProducts = [];
    switch (_showOnlyFavoritos) {
      case Options.all:
        loadedProducts = provider.items;
        break;
      case Options.favorites:
        loadedProducts = provider.favoriteItems;
        break;
      case Options.shopping:
        loadedProducts = provider.carrinhoItems;
        break;
      default:
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //2 produtos por linha
        childAspectRatio: 3 / 2, //diemnsao de cada elemento
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
