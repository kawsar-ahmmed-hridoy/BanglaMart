import 'package:flutter/material.dart';

class TrendingWorkshops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Trending Workshops",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View all",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            scrollDirection: Axis.horizontal,
            children: [
              _trendingWorkshop("Pottery Workshop", "20.99", "4.5", 'assets/images/nakshikantha3.jpg'),
              const SizedBox(width: 12),
              _trendingWorkshop("Weaving Classes", "25.99", "4.7", 'assets/images/nakshikatha2.jpg'),
              const SizedBox(width: 12),
              _trendingWorkshop("Jewelry Making", "30.99", "4.3", 'assets/images/nakshikantha3.jpg'),
              const SizedBox(width: 12),
              _trendingWorkshop("Wood Carving", "15.99", "4.8", 'assets/images/nakshikatha2.jpg'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _trendingWorkshop(String title, String price, String rating, String imagePath) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          Text(
            "\$$price",
            style: const TextStyle(fontSize: 16, color: Color(0xFF05C793)),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFFFCE5C), size: 16),
              const SizedBox(width: 5),
              Text(
                rating,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
