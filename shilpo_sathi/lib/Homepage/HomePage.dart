import 'package:flutter/material.dart';
import 'package:shilpo_sathi/Homepage/DIYCraftWorkshopsPage.dart';
import 'BannerSection.dart';
import 'CategorySection.dart';
import 'LocationSection.dart';
import 'RecentlyAddedSection.dart';
import 'TrendingWorkshopsSection.dart';
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
                  TrendingWorkshops(),
                  SizedBox(height: 20),
                  CategorySection(),
                  SizedBox(height: 20),
                  VirtualShowroom(),
                  SizedBox(height: 10),
                  RecentlyAdded(),
                  SizedBox(height: 20),
                  DIYCraftWorkshopsPage(),
                  SizedBox(height: 20),
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
      backgroundColor: Color(0xFF252C35),
      title: Text(
        "Shilpo Sathi",
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
}