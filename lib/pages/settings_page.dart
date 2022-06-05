import 'package:f6_ecommerce/model/product_list.dart';
import 'package:f6_ecommerce/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorite,
  All,
  Carrinho,
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    print('SettingsPage');
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
      // body of list title product with button edit and button delete
      body: _buildProductList(context)
    );
  }

  // method list title product with button edit and button delete
  Widget _buildProductList(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    return ListView.builder(
      itemCount: provider.items.length,
      itemBuilder: (_, index) {
        final product = provider.items[index];
        return ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/no-image.png',
                image: product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(product.title),
          subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCT_FORM,
                    arguments: product,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  provider.removeProduct(product);
                },
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
        );
      },
    );
  }
}
