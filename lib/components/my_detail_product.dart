import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uraz_store_app/models/product.dart';

import '../models/home.dart';

class MyDetailProduct extends StatelessWidget {
  final Product product;
  const MyDetailProduct({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Home>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Ürün fotoğrafı
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset(
                    product.imagePath,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  // Ürün ismi
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  // Ürün açıklaması
                  ClipRRect(
                    child: Text(
                      product.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Ürün fiyatı
                  Text(
                    '${product.price.toStringAsFixed(2)} ₺',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            provider.toggleFavori(product);
                          },
                          icon: provider.isFavori(product)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_border_outlined),
                          label: const Text('favoriye ekle')),
                      TextButton.icon(
                          onPressed: () {
                            provider.addToCart(product);
                          },
                          icon: const Icon(Icons.shopping_basket_outlined),
                          label: const Text('Sepete ekle')),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
