import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Homepage/HomePage.dart';
import 'Marketplace/MarketplacePage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final Color primaryColor = Color(0xFF26547D);
  final List<Widget> _pages = [
    HomePage(),
    MarketplacePage(),
    CommunityPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: primaryColor,
        buttonBackgroundColor: primaryColor,
        height: 60,
        index: _currentIndex,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.storefront , size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
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


class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Page'),
      ),
      body: Center(
        child: Text('Community Page Content'),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Page'),
      ),
      body: Center(
        child: Text('Account Page Content'),
      ),
    );
  }
}

class ArtisanStorytellingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artisan Storytelling'),
      ),
      body: Center(
        child: Text('Artisan Storytelling Content'),
      ),
    );
  }
}