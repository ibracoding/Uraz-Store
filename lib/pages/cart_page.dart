import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uraz_store_app/components/my_button.dart';
import 'package:uraz_store_app/components/my_detail_product.dart';
import 'package:uraz_store_app/models/home.dart';
import 'package:uraz_store_app/models/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    _loadCartFromSharedPreferences();
  }

  void _loadCartFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartIds = prefs.getStringList('cart');
    if (cartIds != null) {
      List<Product> loadedCart = cartIds.map((id) {
        return context
            .read<Home>()
            .home
            .firstWhere((item) => item.id == int.parse(id));
      }).toList();
      context.read<Home>().setCart(loadedCart);
    }
  }

  void removeItemCart(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
            'Ürünü sepetinizden kaldırıyorsunuz. Bu işleme devam edilsin mi?'),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hayır'),
          ),
          MaterialButton(
            child: Text('Evet'),
            onPressed: () {
              context.read<Home>().removeFromCart(product);
              _saveCartToSharedPreferences();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void _saveCartToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartIds =
        context.read<Home>().cart.map((item) => item.id.toString()).toList();
    prefs.setStringList('cart', cartIds);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Home>().cart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          'Sepetim',
          style: TextStyle(
            fontSize: 25,
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Text(
                        'Sepetinizde ürün bulunmamaktadır.\nÜrünlere göz atabilirsiniz.'),
                  )
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyDetailProduct(product: item),
                            )),
                        child: Card(
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              ListTile(
                                trailing: IconButton(
                                    onPressed: () => removeItemCart(
                                          context,
                                          item,
                                        ),
                                    icon: const Icon(
                                      Icons.highlight_remove_sharp,
                                      color: Colors.red,
                                    )),
                                title: Text(item.name),
                                subtitle: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    '${item.price} ₺',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14),
                                  ),
                                ),
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(item.imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      context.read<Home>().removeFromCart(item);
                                    },
                                  ),
                                  Text(
                                    item.quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ), // Miktarı göster
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      context.read<Home>().addToCart(item);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ),
          // Ödeme yap
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: cart.isEmpty
                ? MyButton(
                    child: const Text('ÜRÜNLERE GİT'),
                    onTap: () => Navigator.pushNamed(context, '/homePage'))
                : Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.yellow.shade50),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Toplam ödeme',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '₺' +
                                    context.watch<Home>().calculateTotalPrice(),
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          GestureDetector(
                            onTap: () async {
                              bool confirmed = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Ödeme Onayı"),
                                    content: const Text(
                                        "Ödemeyi yapmak istediğinizden emin misiniz?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(false); // Onaylanmadı
                                        },
                                        child: const Text("Hayır"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(true); // Onaylandı
                                        },
                                        child: const Text("Evet"),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmed) {
                                context.read<Home>().setCart([]);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Ödeme Tamamlandı"),
                                      content: const Text(
                                          "Ödeme başarıyla tamamlandı."),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Tamam"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  child: const Text(
                                    'Şimdi Öde',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
