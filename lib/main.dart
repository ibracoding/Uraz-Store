import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uraz_store_app/models/home.dart';
import 'package:uraz_store_app/pages/cart_page.dart';
import 'package:uraz_store_app/pages/favorite_page.dart';
import 'package:uraz_store_app/pages/home_page.dart';
import 'package:uraz_store_app/pages/intro_page.dart';
import 'package:uraz_store_app/pages/product_details_page.dart';

import 'models/bottom_navbar.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Home(),
      ),
      ChangeNotifierProvider(
        create: (context) => BottomNavbar(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uraz Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 196, 206, 10)),
        useMaterial3: true,
      ),
      routes: {
        '/introPage': (context) => const IntroPage(),
        '/homePage': (context) => const HomePage(),
        '/favoriPage': (context) => const FavoritePage(),
        '/sepetPage': (context) => const CartPage(),
        '/detayPage': (context) => const ProductDetailsPage(),
      },
      home: const IntroPage(),
    );
  }
}
