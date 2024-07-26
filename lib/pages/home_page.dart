import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uraz_store_app/components/my_bottom_navbar.dart';
import 'package:uraz_store_app/components/my_drawer.dart';
import 'package:uraz_store_app/components/my_product_tile.dart';
import 'package:uraz_store_app/models/bottom_navbar.dart';
import 'package:uraz_store_app/models/home.dart';
import 'package:uraz_store_app/models/product.dart';
import 'package:uraz_store_app/pages/favorite_page.dart';
import 'package:uraz_store_app/pages/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeModel = context.watch<Home>();
    final products = homeModel.searchResults;
    final isSearchClicked = homeModel.isSearchClicked;
    final bottomNavBar = context.watch<BottomNavbar>();

    return Scaffold(
      appBar: _appbarMethod(isSearchClicked, context, homeModel),
      drawer: MyDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          bottomNavBar.setCurrentIndex(index);
        },
        children: [
          _gridViewBuilderMethod(products), // Home
          FavoritePage(), // Favorites
          CartPage(), // Cart
        ],
      ),
      bottomNavigationBar: MyBottomNavbar(
        currentIndex: bottomNavBar.currentIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  GridView _gridViewBuilderMethod(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 0.70,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return MyProductTile(
          product: product,
          item: product,
        );
      },
    );
  }

  AppBar _appbarMethod(
      bool isSearchClicked, BuildContext context, Home homeModel) {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      centerTitle: true,
      title: isSearchClicked
          ? Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: _textFormFieldMethod(context),
            )
          : const Text(
              'Uraz Store',
              style: TextStyle(
                fontSize: 25,
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            ),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            homeModel.toggleSearch();
          },
          icon: Icon(isSearchClicked ? Icons.clear : Icons.search),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartPage()));
          },
          icon: Icon(Icons.shopping_basket_outlined),
        ),
      ],
    );
  }

  TextFormField _textFormFieldMethod(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
        hintStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
        hintText: 'Arama yap',
      ),
      onChanged: (text) {
        context.read<Home>().searchProducts(text);
      },
    );
  }
}
