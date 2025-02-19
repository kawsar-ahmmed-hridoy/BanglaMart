import 'package:flutter/material.dart';

class FeaturedArtisans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildArtisanCard('Nakshi Kantha Weaver', 'assets/images/nakshikatha1.png'),
          _buildArtisanCard('Jamdani Craftsman', 'assets/images/nakshikatha2.jpg'),
          _buildArtisanCard('Terracotta Potter', 'assets/images/nakshikantha3.jpg'),
        ],
      ),
    );
  }

  Widget _buildArtisanCard(String title, String imagePath) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFF93DFD0).withOpacity(0.0),
              Color(0xFFEAF1F1),
            ],
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xFF26547D),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}