import 'package:flutter/material.dart';
import 'BannerSection.dart';
import 'CategorySection.dart';
import 'DIYCraftWorkshopsPage.dart';
import 'LocationSection.dart';
import 'FeaturedArtisan.dart';
import 'VirtualShowroom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocationSection(),
                  SizedBox(height: 20),
                  BannerSection(),
                  SizedBox(height: 20),
                  Featuredartisan(),
                  SizedBox(height: 20),
                  CategorySection(),
                  SizedBox(height: 20),
                  VirtualShowroom(),
                  SizedBox(height: 20),
                  DIYCraftWorkshopsPage(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      //backgroundColor: Colors.white,
      title: Text(
        "Homepage",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.blue),
          onPressed: () {
            Navigator.pushNamed(context, '/notification');
          },
        ),
        SizedBox(width: 20),
      ],
      centerTitle: true,
    );
  }
}