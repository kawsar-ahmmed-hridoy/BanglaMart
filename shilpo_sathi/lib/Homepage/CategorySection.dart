import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _serviceIcon(Icons.brush, "Pottery", () {}),
        _serviceIcon(Icons.elderly_woman, "Weaving", () {}),
        _serviceIcon(Icons.construction, "Woodwork", () {}),
        _serviceIcon(Icons.art_track, "Painting", () {}),
      ],
    );
  }

  Widget _serviceIcon(IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFFFCE5C).withOpacity(0.2),
            child: Icon(icon, color: Color(0xFF26547D)),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 14, color: Color(0xFF26547D))),
        ],
      ),
    );
  }
}