import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VirtualShowroom extends StatefulWidget {
  @override
  _VirtualShowroomState createState() => _VirtualShowroomState();
}

class _VirtualShowroomState extends State<VirtualShowroom> {
  final List<Map<String, String>> banners = [
    {
      "image": "assets/showroom/aarong.jpg",
      "name": "Aarong",
      "description": "Aarong – Bengali for 'village fair' – is Bangladesh's most popular lifestyle retail chain.",
      "url": "https://www.aarong.com/",
    },
    {
      "image": "assets/showroom/evaly.jpg",
      "name": "Evaly",
      "description": "E-valy is capable of providing every kind of goods and products from every sector to every consumer located in Bangladesh.",
      "url": "https://www.evaly.com.bd/",
    },
    {
      "image": "assets/showroom/lereve.jpg",
      "name": "Le reve",
      "description": "Le Reve, the leading fashion brand in Bangladesh, is synonymous with trendy and effortless style.",
      "url": "https://www.lerevecraze.com/",
    },
    {
      "image": "assets/showroom/sailor.jpg",
      "name": "Sailor",
      "description": "Sailor is an eminent lifestyle brand in the retail fashion industry of Bangladesh with the purpose of Sailing life.",
      "url": "https://www.sailor.clothing/",
    },
  ];

  int _currentBannerIndex = 0;
  bool _isForward = true;
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
        if (_isForward) {
          _currentBannerIndex = (_currentBannerIndex + 1) % banners.length;
          if (_currentBannerIndex == banners.length - 1) {
            _isForward = false;
          }
        } else {
          _currentBannerIndex = (_currentBannerIndex - 1) % banners.length;
          if (_currentBannerIndex == 0) {
            _isForward = true;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) {
      return Center(child: Text("No banners available"));
    }

    final currentBanner = banners[_currentBannerIndex];
    final imagePath = currentBanner["image"] ?? "assets/default_image.jpg";
    final name = currentBanner["name"] ?? "Unknown";
    final description = currentBanner["description"] ?? "No description available";
    final url = currentBanner["url"] ?? "https://example.com";

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
            ),
          ),
        ),
        SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              Offset begin = _isForward ? Offset(1.0, 0.0) : Offset(-1.0, 0.0);
              Offset end = Offset.zero;
              return SlideTransition(
                position: Tween<Offset>(begin: begin, end: end).animate(animation),
                child: child,
              );
            },
            child: KeyedSubtree(
              key: ValueKey<int>(_currentBannerIndex),
              child: _buildBanner(imagePath, name, description, url),
            ),
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

  Widget _buildBanner(String imagePath, String name, String description, String url) {
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
            begin: Alignment.center,
            end: Alignment.center,
            colors: [
              Color(0xFFD3E6E3).withOpacity(0.7),
              Colors.white.withOpacity(0.4),
            ],
          ),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF046048),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                _navigateToWebsite(url);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(50, 30),
                backgroundColor: Color(0xFFEF436B),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                "Go Website",
                style: TextStyle(
                  fontSize: 12,
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

  void _navigateToWebsite(String url) {
    //print("Navigating to: $url");
    launch(url);
  }
}