import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'banner_provider.dart';

class BannerDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);
    final banner = bannerProvider.selectedBanner;

    if (banner == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("No banner selected"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(banner["title"]),
        backgroundColor: Color(0xFF26547D),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                banner["imagePath"],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              banner["title"],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26547D),
              ),
            ),
            SizedBox(height: 10),
            Text(
              banner["location"],
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF05C793),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              banner["description"],
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Text(
              "Address: ${banner["address"]}",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              "Start Date: ${banner["startDate"]}",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              "End Date: ${banner["endDate"]}",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Text(
              "Location on Map:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26547D),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: banner["mapLocation"],
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId("event_location"),
                    position: banner["mapLocation"],
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
