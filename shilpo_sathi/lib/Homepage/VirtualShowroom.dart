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
      "url": "https://www.aarong.com/",
    },
    {
      "image": "assets/showroom/evaly.jpg",
      "name": "Evaly",
      "url": "https://www.evaly.com.bd/",
    },
    {
      "image": "assets/showroom/lereve.jpg",
      "name": "Le Reve",
      "url": "https://www.lerevecraze.com/",
    },
    {
      "image": "assets/showroom/sailor.jpg",
      "name": "Sailor",
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
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        if (_isForward) {
          _currentBannerIndex = (_currentBannerIndex + 1) % banners.length;
          if (_currentBannerIndex == banners.length - 1) _isForward = false;
        } else {
          _currentBannerIndex = (_currentBannerIndex - 1) % banners.length;
          if (_currentBannerIndex == 0) _isForward = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) {
      return Center(child: Text("No banners available"));
    }

    final banner = banners[_currentBannerIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Text(
                "Verified Store",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 700),
            transitionBuilder: (child, animation) {
              final slide = Tween<Offset>(
                begin: _isForward ? Offset(1.0, 0.0) : Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(
                position: slide,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: KeyedSubtree(
              key: ValueKey(_currentBannerIndex),
              child: _buildBanner(
                banner["image"]!,
                banner["name"]!,
                banner["url"]!,
              ),
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

  Widget _buildBanner(String imagePath, String name, String url) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.blueGrey.withOpacity(0.4), Colors.indigo.withOpacity(0.2)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.store_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 6),
                      Text(name,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 70),
                  ElevatedButton.icon(
                    onPressed: () => _navigateToWebsite(url),
                    icon: Icon(Icons.link, size: 18, color: Colors.white),
                    label: Text("Visit Website", style: TextStyle(fontSize: 13, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEF436B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFEF436B) : Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }

  void _navigateToWebsite(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch website")),
      );
    }
  }
}
