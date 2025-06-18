import 'package:flutter/material.dart';

class CategoryListPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.brush, 'label': 'Pottery'},
    {'icon': Icons.elderly_woman, 'label': 'Weaving'},
    {'icon': Icons.construction, 'label': 'Woodwork'},
    {'icon': Icons.art_track, 'label': 'Painting'},
    {'icon': Icons.crop, 'label': 'Embroidery'},
    {'icon': Icons.format_paint, 'label': 'Calligraphy'},
    {'icon': Icons.bolt, 'label': 'Metal Craft'},
    {'icon': Icons.recycling, 'label': 'Recycled Art'},
    {'icon': Icons.emoji_nature, 'label': 'Nature Art'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  child: Icon(category['icon'], size: 30),
                ),
                const SizedBox(height: 6),
                Text(
                  category['label'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
