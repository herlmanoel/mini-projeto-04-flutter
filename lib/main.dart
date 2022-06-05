import 'package:f6_ecommerce/model/product_list.dart';
import 'package:f6_ecommerce/pages/carrinho_page.dart';
import 'package:f6_ecommerce/pages/product_detail_page.dart';
import 'package:f6_ecommerce/pages/product_form_page.dart';
import 'package:f6_ecommerce/pages/products_overview_page.dart';
import 'package:f6_ecommerce/pages/settings_page.dart';
import 'package:f6_ecommerce/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

bool shouldUseFirestoreEmulator = false;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductList(),
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
            fontFamily: 'Lato',
            //primarySwatch: Colors.pink,
            colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                primary: Color.fromRGBO(233, 30, 99, 1), secondary: Colors.orangeAccent)),
        home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.PRODUCT_FORM: (context) => const ProductFormPage(),
          AppRoutes.CARRINHO: (context) => const CarrinhoPage(),
          AppRoutes.SETTINGS: (context) => const SettingsPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
