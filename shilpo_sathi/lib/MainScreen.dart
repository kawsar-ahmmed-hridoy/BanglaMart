import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Account/AccountPage.dart';
import 'Cart/CartPage.dart';
import 'Homepage/HomePage.dart';
import 'Marketplace/MarketplacePage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MarketplacePage(),
    CartPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color navBarColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final Color iconColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: navBarColor,
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        height: 60,
        index: _currentIndex,
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.home, size: 30, color: iconColor),
          Icon(Icons.storefront, size: 30, color: iconColor),
          Icon(Icons.shopping_cart, size: 30, color: iconColor),
          Icon(Icons.person, size: 30, color: iconColor),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
