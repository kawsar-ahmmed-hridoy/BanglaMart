import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerSection extends StatefulWidget {
  @override
  _BannerSectionState createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  final List<Map<String, dynamic>> banners = [
    {
      "title": "পহেলা বৈশাখ উৎসব",
      "location": "রমনা, ঢাকা",
      "imagePath": 'assets/images/nakshikatha2.jpg',
      "description": "Experience the vibrant celebrations of Pohela Boishakh, the Bengali New Year, with cultural programs, traditional food, and music.",
      "address": "Ramna Park, Dhaka",
      "startDate": "April 14, 2025",
      "endDate": "April 14, 2025",
      "mapLocation": LatLng(23.7333, 90.4066),
    },
    {
      "title": "বাণিজ্য মেলা ২০২৫",
      "location": "আগারগাঁও, ঢাকা",
      "imagePath": 'assets/images/nakshikantha3.jpg',
      "description": "Explore the largest trade fair in Bangladesh, showcasing products from various industries.",
      "address": "Agargaon, Dhaka",
      "startDate": "January 1, 2025",
      "endDate": "January 31, 2025",
      "mapLocation": LatLng(23.7772, 90.3995),
    },
    {
      "title": "কুটিরশিল্প উৎসব ২০২৫",
      "location": "বন্দরবাজার, সিলেট",
      "imagePath": 'assets/images/nakshikantha3.jpg',
      "description": "Discover the beauty of traditional cottage industries and handmade crafts.",
      "address": "Bandarbazar, Sylhet",
      "startDate": "March 1, 2025",
      "endDate": "March 7, 2025",
      "mapLocation": LatLng(24.8949, 91.8687),
    },
    {
      "title": "গ্রামীণ শিল্প মেলা ২০২৫",
      "location": "কুষ্টিয়া সদর",
      "imagePath": 'assets/images/nakshikatha2.jpg',
      "description": "A fair dedicated to rural arts and crafts, promoting local artisans.",
      "address": "Kushtia Sadar, Kushtia",
      "startDate": "February 10, 2025",
      "endDate": "February 20, 2025",
      "mapLocation": LatLng(23.9015, 89.1228),
    },
  ];

  int _currentBannerIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Events Nearby You", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIdx) {
            return _bannerPage(data: banners[index]);
          },
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 8,
            onPageChanged: (index, reason) => setState(() => _currentBannerIndex = index),
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

  Widget _bannerPage({required Map<String, dynamic> data}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.3),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data["title"], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text(data["location"], style: TextStyle(fontSize: 10, color: Color(0xFF05C793))),
                SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () => _showDetails(context, data),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEF436B),
                    minimumSize: Size(70, 15),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  child: Text("View details", style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              data["imagePath"],
              height: 120,
              width: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 80),
            ),
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

  void _showDetails(BuildContext context, Map<String, dynamic> data) {
    final LatLng location = data["mapLocation"];
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(data["title"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(data["description"], style: TextStyle(fontSize: 14)),
              SizedBox(height: 12),
              Text("📍 Location: ${data["address"]}"),
              Text("🗓️ Date: ${data["startDate"]} - ${data["endDate"]}"),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
                    await launchUrl(Uri.parse(googleMapsUrl), mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not open Google Maps")));
                  }
                },
                icon: Icon(Icons.location_on_outlined, color: Colors.white),
                label: Text("Open in Google Maps", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
