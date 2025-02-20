import 'package:flutter/material.dart';

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
                  color: Color(0xFF26547D),
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
            backgroundColor: const Color(0xFFFFCE5C).withOpacity(0.2),
            child: Icon(icon, color: const Color(0xFF26547D)),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF26547D)),
          ),
        ],
      ),
    );
  }
}
