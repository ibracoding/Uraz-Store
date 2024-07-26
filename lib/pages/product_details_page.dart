import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uraz_store_app/components/my_detail_product.dart';
import 'package:uraz_store_app/models/home.dart';
import 'package:uraz_store_app/models/product.dart';

class ProductDetailsPage extends StatelessWidget {
 const  ProductDetailsPage({super.key});

  void removeItemDetay(BuildContext context, Product product) {}

  @override
  Widget build(BuildContext context) {
    final products = context.watch<Home>().detay;
    context.read<Home>().detay;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ürün Detay Sayfası',
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return MyDetailProduct(
                    product: product,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*

Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset("assets/${widget.product.image}"),
          Text(
            "${widget.product.price} ₺",
            style: const TextStyle(fontSize: 20),
          ),
          Card(
            child: TextFieldTapRegion(
                child: Text(
                    "Her geçen gün yazılım hayatımızın en derinine kadar iniyor.Hayatımızı kolaylaştırırken yazılımcılara büyük bir iş alanı açılıyor. Çok geç olmadan bu dijital çağa ayak uydurmalı ve yazılım sektöründe yer almalısınız.Bu dijitalleşen çağda ortalama bir bilgisayar ile kendinize yeni bir iş fırsatı yaratabilirsiniz. ")),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Sepete ekle ₺",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Satın al ₺",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          )
        ]),
*/