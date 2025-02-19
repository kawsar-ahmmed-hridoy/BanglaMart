import 'package:flutter/material.dart';

class DIYCraftWorkshopsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DIY Craft Workshops",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26547D),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _workshopCard(
                    title: "Handmade Pottery Workshop",
                    price: "20.99",
                    rating: "4.5",
                    imagePath: 'assets/images/pottery.jpg',
                    description:
                    "Learn the art of pottery and create beautiful handmade items.",
                  ),
                  SizedBox(height: 15),
                  _workshopCard(
                    title: "Traditional Weaving Classes",
                    price: "25.99",
                    rating: "4.7",
                    imagePath: 'assets/images/weaving.jpg',
                    description:
                    "Discover the traditional techniques of weaving and create your own fabric.",
                  ),
                  SizedBox(height: 15),
                  _workshopCard(
                    title: "DIY Jewelry Making",
                    price: "30.99",
                    rating: "4.3",
                    imagePath: 'assets/images/jewelry.jpg',
                    description:
                    "Design and create your own unique jewelry pieces.",
                  ),
                  SizedBox(height: 15),
                  _workshopCard(
                    title: "Wood Carving Workshop",
                    price: "15.99",
                    rating: "4.8",
                    imagePath: 'assets/images/woodcarving.jpg',
                    description:
                    "Master the art of wood carving and create intricate designs.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _workshopCard({
    required String title,
    required String price,
    required String rating,
    required String imagePath,
    required String description,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26547D),
              ),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$$price",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF05C793),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xFFFFCE5C), size: 16),
                    SizedBox(width: 5),
                    Text(
                      rating,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF26547D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
              },
              child: Text(
                "View Details",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEF436B),
                minimumSize: Size(double.infinity, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF26547D),
      title: Text(
        "DIY Craft Workshops",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}