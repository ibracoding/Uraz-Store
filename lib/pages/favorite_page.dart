import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uraz_store_app/components/my_button.dart';
import 'package:uraz_store_app/components/my_detail_product.dart';
import 'package:uraz_store_app/models/home.dart';
import 'package:uraz_store_app/models/product.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    _loadFavoriFromSharedPreferences();
  }

  void _loadFavoriFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favoriIds = prefs.getStringList('favori');
    if (favoriIds != null) {
      List<Product> loadedFavori = favoriIds.map((id) {
        return context
            .read<Home>()
            .favori
            .firstWhere((item) => item.id == int.parse(id));
      }).toList();
      context.read<Home>().setFavori(loadedFavori);
    }
  }

  void _saveFavoriToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriIds =
        context.read<Home>().favori.map((item) => item.id.toString()).toList();
    prefs.setStringList('favori', favoriIds);
  }

  void removeItemFavori(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
            'Ürünü favorilerinizden kaldırıyorsunuz. Bu işleme devam edilsin mi?'),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hayır'),
          ),
          MaterialButton(
            child: const Text(
              'Evet',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              context.read<Home>().toggleFavori(product);
              _saveFavoriToSharedPreferences();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Home>(context);
    final favori = provider.favori;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          'Favori Page',
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
            child: provider.favori.isEmpty
                ? const Center(
                    child: Text(
                        'Favorinizde ürün bulunmamaktadır.\nÜrünlere göz atabilirsiniz.'),
                  )
                : ListView.builder(
                    itemCount: favori.length,
                    itemBuilder: (context, index) {
                      final item = favori[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyDetailProduct(product: item),
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(5),
                          child: ListTile(
                            trailing: IconButton(
                              onPressed: () => removeItemFavori(
                                context,
                                item,
                              ),
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                            title: Text(item.name),
                            subtitle: Text(
                              '${item.price} ₺',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                  fontSize: 20),
                            ),
                            leading: Container(
                              width: 50, // Genişlik
                              height: 50, // Yükseklik
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10), // Köşe yuvarlatma
                                image: DecorationImage(
                                  image: AssetImage(item.imagePath), // Görsel
                                  fit: BoxFit.cover, // Görselin kapsama ayarı
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ),
          // Ödeme yap
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: favori.isEmpty
                ? MyButton(
                    child: const Text('ÜRÜNLERE GİT'),
                    onTap: () => Navigator.pushNamed(context, '/homePage'))
                : null,
          )
        ],
      ),
    );
  }
}
