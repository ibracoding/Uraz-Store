import 'package:flutter/material.dart';
import 'package:uraz_store_app/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Logo
              const DrawerHeader(
                child: Icon(
                  Icons.star,
                  size: 60,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              //Anasayfa

              MyListTile(
                icon: Icons.home_max_outlined,
                title: 'Anasayfa',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/homePage');
                },
                text: 'Anasayfa',
              ),
              // Favoriler
              MyListTile(
                icon: Icons.favorite,
                title: 'Favorilerim',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context,
                      '/favoriPage'); // Favoriler sayfasına yönlendirme
                },
                text: 'Favorilerim',
              ),
              // Sepet
              MyListTile(
                icon: Icons.shopping_cart,
                title: 'Sepetim',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/sepetPage');
                },
                text: 'Sepetim',
              ),
            ],
          ),
          // Çıkış
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.exit_to_app,
              title: 'Çıkış',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/introPage');
              },
              text: 'Çıkış',
            ),
          ),
        ],
      ),
    );
  }
}
