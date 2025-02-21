import 'dart:async';
import 'package:flutter/material.dart';

class BannerSection extends StatefulWidget {
  @override
  _BannerSectionState createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  final List<Map<String, String>> banners = [
    {
      "title": "পহেলা বৈশাখ উৎসব",
      "location": "রমনা, ঢাকা",
      "imagePath": 'assets/images/nakshikatha2.jpg',
    },
    {
      "title": "বাণিজ্য মেলা ২০২৫",
      "location": "আগারগাঁও, ঢাকা",
      "imagePath": 'assets/images/nakshikantha3.jpg',
    },
    {
      "title": "কুটিরশিল্প উৎসব ২০২৫",
      "location": "বন্দরবাজার, সিলেট",
      "imagePath": 'assets/images/nakshikantha3.jpg',
    },
    {
      "title": "গ্রামীণ শিল্প মেলা ২০২৫",
      "location": "কুষ্টিয়া সদর",
      "imagePath": 'assets/images/nakshikatha2.jpg',
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
        Text("Events Nearby You",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF26547D)),),
        SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: _bannerPage(
                  title: banners[_currentBannerIndex]["title"]!,
                  location: banners[_currentBannerIndex]["location"]!,
                  imagePath: banners[_currentBannerIndex]["imagePath"]!,
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

  Widget _bannerPage({required String title, required String location, required String imagePath}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFF05C793).withOpacity(0.1),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF26547D)),
                ),
                SizedBox(height: 6),
                Text(
                  location,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF05C793)),
                ),
                SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("View details", style: TextStyle(color: Colors.white, fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEF436B),
                    minimumSize: Size(70, 15),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagePath, height: 120, width: 140, fit: BoxFit.cover),
          ),
        ],
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
