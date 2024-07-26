import 'package:flutter/material.dart';

class MyBottomNavbar extends StatelessWidget {
  const MyBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.amber, // Aktif icon rengi
      unselectedItemColor: Colors.grey, // Pasif icon rengi
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max_outlined),
          label: 'Anasayfa',
          activeIcon:
              Icon(Icons.home, color: Colors.amber), // Aktif durumda olan ikon
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          label: 'Favoriler',
          activeIcon: Icon(Icons.favorite,
              color: Colors.amber), // Aktif durumda olan ikon
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket_outlined),
          label: 'Sepetim',
          activeIcon: Icon(Icons.shopping_cart,
              color: Colors.amber), // Aktif durumda olan ikon
        ),
      ],
    );
  }
}
