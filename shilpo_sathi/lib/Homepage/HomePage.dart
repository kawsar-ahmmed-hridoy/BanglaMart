import 'package:flutter/material.dart';
import 'FeaturedArtisans.dart';
import 'ARVirtualShowroom.dart';
import 'DIYCraftWorkshops.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome to ShilpoSathi!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF26547D),
                ),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildSearchBar(),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Featured Artisans', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF26547D),),),
            ),
            SizedBox(height: 10),
            FeaturedArtisans(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('AR Virtual Showroom', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF26547D),),),
            ),
            SizedBox(height: 10),
            ARVirtualShowroom(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('DIY Craft Workshops', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF26547D),),),
            ),
            SizedBox(height: 10),
            DIYCraftWorkshops(),
            SizedBox(height: 55),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF26547D),
      title: Row(
        children: [
          SizedBox(width: 20),
          Text(
            "Homepage",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/notification');
          },
        ),
        SizedBox(width: 20),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for crafts or artisans...',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }
}