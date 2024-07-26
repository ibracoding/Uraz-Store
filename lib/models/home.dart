import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'product.dart';

class Home extends ChangeNotifier {
  final List<Product> _home = [
    Product(
        id: 1,
        imagePath: "assets/1.png",
        name: "Sandalet lüx",
        price: 850,
        description:
            'Ürünlerinizin özelliklerini ve faydalarını etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 2,
        imagePath: "assets/2.png",
        name: "Apple Watch 40 inç",
        price: 2500,
        description:
            'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 3,
        imagePath: "assets/3.png",
        name: "Bilgisayar Çantası",
        price: 40000,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 4,
        imagePath: "assets/4.png",
        name: "Siyah Çanta Larce",
        price: 2000,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 5,
        imagePath: "assets/5.png",
        name: "Pembe Çanta Medium Boy",
        price: 8000,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 6,
        imagePath: "assets/6.png",
        name: "Sandalet Siyah Özel Gün",
        price: 18000,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 7,
        imagePath: "assets/7.png",
        name: "Casio MX Series",
        price: 50000,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 8,
        imagePath: "assets/8.png",
        name: "Macbook 13 inç",
        price: 32000,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 9,
        imagePath: "assets/9.png",
        name: "Rayban Club Master",
        price: 32000,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 10,
        imagePath: "assets/10.png",
        name: "Sony ZX Series",
        price: 32000,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 11,
        imagePath: "assets/11.png",
        name: "Gio Armani",
        price: 32000,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 12,
        imagePath: "assets/12.png",
        name: "Casio X Series",
        price: 7500,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 13,
        imagePath: "assets/13.png",
        name: "Dyson V8",
        price: 32000,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
    Product(
        id: 14,
        imagePath: "assets/14.png",
        name: "IPhone 13",
        price: 500,
        description: 'Ürünlerinizin etkili şekilde anlatan ürün açıklamalarıyla organik trafiğinizi ve dönüşüm oranlarınızı artırın.'),
  ];

  List<Product> _cart = [];
  List<Product> _favori = [];
  List<Product> _detay = [];
  List<Product> _search = [];
  List<Product> _searchResults = [];
  bool _isSearchClicked = false;

  Home() {
    _loadCart();
    _loadFavori();
    _loadDetay();
  }

  // Getters
  List<Product> get home => _home;
  List<Product> get cart => _cart;
  List<Product> get favori => _favori;
  List<Product> get detay => _detay;
  List<Product> get search => _search;
  List<Product> get searchResults =>
      _searchResults.isNotEmpty ? _searchResults : _home;

  bool get isSearchClicked => _isSearchClicked;

  void addToCart(Product item) {
    final index = _cart.indexWhere((product) => product.id == item.id);
    if (index != -1) {
      _cart[index].quantity = (_cart[index].quantity ?? 0) + 1; // Miktarı artır
    } else {
      _cart.add(item);
    }
    _saveCart();
    notifyListeners();
  }

  void removeFromCart(Product item) {
    final index = _cart.indexWhere((product) => product.id == item.id);
    if (index != -1) {
      if ((_cart[index].quantity ?? 1) > 1) {
        _cart[index].quantity =
            (_cart[index].quantity ?? 1) - 1; // Miktarı azalt
      } else {
        _cart.removeAt(index); // Sepetten kaldır
      }
    }
    _saveCart();
    notifyListeners();
  }

  // Favori operations
  void toggleFavori(Product item) {
    final isFavori = _favori.contains(item);
    // Favori listesinde var mı kontrol ediyoruz.
    if (isFavori) {
      _favori.remove(item);
    } else {
      _favori.add(item);
    }
    _saveFavori();
    _loadFavori();
    notifyListeners();
  }

  bool isFavori(Product item) {
    final isFavori = _favori.contains(item);
    return isFavori;
  }

  // Save and load favori
  void _saveFavori() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriIds = _favori.map((item) => item.id.toString()).toList();
    prefs.setStringList('favori', favoriIds);
  }

  void _loadFavori() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favoriIds = prefs.getStringList('favori');
    if (favoriIds != null) {
      _favori = favoriIds
          .map((id) => _home.firstWhere((item) => item.id == int.parse(id)))
          .toList();
      notifyListeners();
    }
  }

  // Detay operations
  void addToDetay(Product item) {
    _detay.add(item);
    _saveDetay();
    notifyListeners();
  }

  void removeToDetay(Product item) {
    _detay.remove(item);
    _saveDetay();
    notifyListeners();
  }

  // Save and load cart
  void _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartIds = _cart.map((item) => item.id.toString()).toList();
    prefs.setStringList('cart', cartIds);
  }

  void _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartIds = prefs.getStringList('cart');
    if (cartIds != null) {
      _cart = cartIds
          .map((id) => _home.firstWhere((item) => item.id == int.parse(id)))
          .toList();
      notifyListeners();
    }
  }

  // Save and load detay
  void _saveDetay() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> detayIds = _detay.map((item) => item.id.toString()).toList();
    prefs.setStringList('detay', detayIds);
  }

  void _loadDetay() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? detayIds = prefs.getStringList('detay');
    if (detayIds != null) {
      _detay = detayIds
          .map((id) => _home.firstWhere((item) => item.id == int.parse(id)))
          .toList();
      notifyListeners();
    }
  }

  // Setters
  void setCart(List<Product> newCart) {
    _cart = newCart;
    notifyListeners();
  }

  void setFavori(List<Product> newFavori) {
    _favori = newFavori;
    notifyListeners();
  }

  // Total price
  String calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var product in _cart) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice.toStringAsFixed(2);
  }

  // Search operations
  void searchProducts(String query) {
    if (query.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _home.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  // Toggle search state
  void toggleSearch() {
    _isSearchClicked = !_isSearchClicked;
    if (!_isSearchClicked) {
      _searchResults.clear();
    }
    notifyListeners();
  }

  void removeToCart(Product product) {}
}
