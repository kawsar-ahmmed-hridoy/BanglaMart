import 'dart:async';

import 'package:flutter/material.dart';

class VirtualShowroom extends StatefulWidget {
  @override
  _VirtualShowroomState createState() => _VirtualShowroomState();
}

class _VirtualShowroomState extends State<VirtualShowroom> {
  final List<Map<String, String>> banners = [
    {
      "image": "assets/images/pottery.jpg",
      "name": "Handmade Pottery",
      "description": "Explore exquisite handmade pottery crafted by skilled artisans.",
    },
    {
      "image": "assets/images/textiles.jpg",
      "name": "Traditional Textiles",
      "description": "Discover the beauty of traditional woven fabrics and patterns.",
    },
    {
      "image": "assets/images/jewelry.jpg",
      "name": "Artisan Jewelry",
      "description": "Adorn yourself with unique, handcrafted jewelry pieces.",
    },
  ];

  int _currentBannerIndex = 0;
  bool _isVisible = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startBannerTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startBannerTimer() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        _isVisible = false;
      });

      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _currentBannerIndex = (_currentBannerIndex + 1) % banners.length;
          _isVisible = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Text(
            "Virtual Showroom",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF26547D),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: _buildBanner(
                  banners[_currentBannerIndex]["image"]!,
                  banners[_currentBannerIndex]["name"]!,
                  banners[_currentBannerIndex]["description"]!,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (index) => _buildIndicator(index == _currentBannerIndex),
          ),
        ),
      ],
    );
  }

  Widget _buildBanner(String imagePath, String name, String description) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFF93DFD0).withOpacity(0.3),
              Colors.black.withOpacity(0.4),
            ],
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEF436B),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                "View Details",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Color(0xFFEF436B) : Colors.grey[400],
      ),
    );
  }
}