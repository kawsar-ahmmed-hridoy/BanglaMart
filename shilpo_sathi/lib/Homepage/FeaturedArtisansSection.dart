import 'package:flutter/material.dart';

import 'FeaturedArtisans.dart';

class FeaturedArtisansSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Featured Artisans", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF26547D))),
            TextButton(
              onPressed: () {
              },
              child: Text("View all", style: TextStyle(color: Color(0xFFEF436B))),
            ),
          ],
        ),
        SizedBox(height: 10),
        FeaturedArtisans(),
      ],
    );
  }
}