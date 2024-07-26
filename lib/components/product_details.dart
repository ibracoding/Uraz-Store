import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uraz_store_app/components/my_detail_product.dart';
import 'package:uraz_store_app/models/product.dart';

import '../models/home.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({required this.product, super.key});

  void addToCart(BuildContext context) {
    context.read<Home>().addToCart(product);
  }

  void addToFavori(BuildContext context) {
    context.read<Home>().toggleFavori(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          //ürün fotoğrafı
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyDetailProduct(product: product))),
            child: Container(
              padding: EdgeInsets.zero,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Text('${product.imagePath}'),
            ),
          ),

          //ürün adı
          Text(product.name),

          //ürün açıklaması
          Text(product.description),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //ürün fiyatı ve sepete ekle
              Text('${product.price.toStringAsFixed(2)} ₺'),

              IconButton(
                icon: const Icon(Icons.shopping_basket_outlined),
                onPressed: () => addToCart(context),
              )
            ],
          ),
        ],
      ),
    );
  }
}
