import 'package:f6_ecommerce/components/product_grid.dart';
import 'package:f6_ecommerce/model/options.dart';
import 'package:f6_ecommerce/model/product_list.dart';
import 'package:f6_ecommerce/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorite,
  All,
  Carrinho,
}

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({Key? key}) : super(key: key);

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    print('CarrinhoPage');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM,
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.CARRINHO,
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.SETTINGS,
              );
            },
            icon: const Icon(Icons.settings),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              const PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
              const PopupMenuItem(
                child: Text('Carrinho'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  //provider.showFavoriteOnly();
                  _showOnlyFavorites = true;
                } else {
                  //provider.showAll();
                  _showOnlyFavorites = false;
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Total: " + provider.getTotalFormat()),
            const SizedBox(
              height: 400,
              child: ProductGrid(Options.shopping),),
          ],
        ),
      ),
    );
  }
}
