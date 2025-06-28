import 'package:flutter/material.dart';
import 'CategoryListPage.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryListPage(),
                    ),
                  );
                },
                child: const Text(
                  "View all",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _serviceIcon(Icons.brush, "Pottery", () {}),
            _serviceIcon(Icons.elderly_woman, "Weaving", () {}),
            _serviceIcon(Icons.construction, "Woodwork", () {}),
            _serviceIcon(Icons.art_track, "Painting", () {}),
          ],
        ),
      ],
    );
  }

  Widget _serviceIcon(IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.8),
            child: Icon(icon),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
