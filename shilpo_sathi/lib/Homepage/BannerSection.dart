import 'package:flutter/material.dart';

class BannerSection extends StatelessWidget {
  final PageController pageController;

  BannerSection({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: [
          _bannerPage(
            title: "Handcrafted Pottery Workshop",
            discount: "20% OFF",
            imagePath: 'assets/images/nakshikatha2.jpg',
          ),
          _bannerPage(
            title: "Traditional Weaving Classes",
            discount: "15% OFF",
            imagePath: 'assets/images/nakshikantha3.jpg',
          ),
          _bannerPage(
            title: "DIY Jewelry Making",
            discount: "10% OFF",
            imagePath: 'assets/images/nakshikatha2.jpg',
          ),
          _bannerPage(
            title: "Wood Carving Workshop",
            discount: "25% OFF",
            imagePath: 'assets/images/nakshikantha3.jpg',
          ),
        ],
      ),
    );
  }

  Widget _bannerPage({required String title, required String discount, required String imagePath}) {
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
                  discount,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF05C793)),
                ),
                SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {
                  },
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
}