import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uraz_store_app/components/my_detail_product.dart';

import '../models/home.dart';
import '../models/product.dart';

class MyProductTile extends StatelessWidget {
  final Product product;
  final Product item;
  const MyProductTile({required this.item, required this.product, super.key});

  void addToCart(BuildContext context) {
    context.read<Home>().addToCart(product);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Home>(context);

    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //ürün fotoğrafı

          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyDetailProduct(product: product)),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      provider.toggleFavori(item);
                    },
                    icon: provider.isFavori(item)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border_outlined),
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  height: 90,
                  width: 80,
                  child: Image.asset(
                    product.imagePath,
                  ),
                ),
              ],
            ),
          ),

          //ürün adı
          Align(alignment: Alignment.centerLeft, child: Text(product.name)),

          //ürün açıklaması

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //ürün fiyatı ve sepete ekle
              Text('${product.price.toStringAsFixed(2)} ₺'),

              IconButton(
                icon: const Icon(Icons.shopping_basket_outlined),
                onPressed: () {
                  addToCart(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void toggleFavori(BuildContext context) {
    context.read<Home>().toggleFavori(item);
  }
}
