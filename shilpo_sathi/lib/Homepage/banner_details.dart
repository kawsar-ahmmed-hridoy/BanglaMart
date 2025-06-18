import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'banner_provider.dart';

class BannerDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final banner = Provider.of<BannerProvider>(context).selectedBanner;

    if (banner == null) {
      return Scaffold(
        body: Center(child: Text("No banner selected.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(banner['title']),
        backgroundColor: Color(0xFFEF436B),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(banner['imagePath'], width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text(
              banner['title'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(banner['location'], style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 16),
            Text(banner['description']),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 8),
                Text("${banner['startDate']} - ${banner['endDate']}"),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.place, size: 16),
                SizedBox(width: 8),
                Text(banner['address']),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: banner['mapLocation'] as LatLng,
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('event'),
                      position: banner['mapLocation'] as LatLng,
                      infoWindow: InfoWindow(title: banner['title']),
                    ),
                  },
                  zoomControlsEnabled: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
