import 'package:flutter/material.dart';

class TrendingWorkshops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _trendingWorkshop("Pottery Workshop", "20.99", "4.5", 'assets/images/nakshikantha3.jpg'),
          SizedBox(width: 10),
          _trendingWorkshop("Weaving Classes", "25.99", "4.7", 'assets/images/nakshikatha2.jpg'),
          SizedBox(width: 10),
          _trendingWorkshop("Jewelry Making", "30.99", "4.3", 'assets/images/nakshikantha3.jpg'),
          SizedBox(width: 10),
          _trendingWorkshop("Wood Carving", "15.99", "4.8", 'assets/images/nakshikatha2.jpg'),
        ],
      ),
    );
  }

  Widget _trendingWorkshop(String title, String price, String rating, String imagePath) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFF05C793).withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF26547D))),
          SizedBox(height: 5),
          Text("\$$price", style: TextStyle(fontSize: 16, color: Color(0xFF05C793))),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.star, color: Color(0xFFFFCE5C), size: 16),
              SizedBox(width: 5),
              Text(rating, style: TextStyle(fontSize: 14, color: Color(0xFF26547D))),
            ],
          ),
        ],
      ),
    );
  }
}