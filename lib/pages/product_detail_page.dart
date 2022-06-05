import 'package:f6_ecommerce/model/product.dart';
import 'package:f6_ecommerce/model/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    final provider = Provider.of<ProductList>(context);
    if (product.quantity == 0) {
      provider.removeIdCarrinho(product.id);
    } else if (product.quantity == 1) {
      provider.setIdCarrinho(product.id);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            provider.updateProductList(product);
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(product.title),
      ),
      // body of product page
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.getPriceFormat(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            // component quantity of product
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    product.decrementQuantity();
                    setState(() {});
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  product.quantity.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    product.incrementQuantity();

                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
