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

  void _nextBanner() {
    setState(() {
      _currentBannerIndex = (_currentBannerIndex + 1) % banners.length;
    });
  }

  void _previousBanner() {
    setState(() {
      _currentBannerIndex = (_currentBannerIndex - 1 + banners.length) % banners.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final banner = banners[_currentBannerIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Verified Store",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 12),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
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
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _previousBanner,
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            ...List.generate(
              banners.length,
                  (index) => _buildIndicator(index == _currentBannerIndex),
            ),
            IconButton(
              onPressed: _nextBanner,
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBanner(String imagePath, String name, String url) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.blueGrey.withOpacity(0.4),
                  Colors.indigo.withOpacity(0.2),
                ],
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
                      const Icon(Icons.store_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 70),
                  ElevatedButton.icon(
                    onPressed: () => _navigateToWebsite(url),
                    icon: const Icon(Icons.link, size: 18, color: Colors.white),
                    label: const Text(
                      "Visit Website",
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF436B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFEF436B) : Colors.grey[400],
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
        const SnackBar(content: Text("Could not launch website")),
      );
    }
  }
}
