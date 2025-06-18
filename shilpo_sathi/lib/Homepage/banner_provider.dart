import 'package:flutter/material.dart';

import 'banner_details.dart';

class BannerProvider with ChangeNotifier {
  Map<String, dynamic>? _selectedBanner;

  Map<String, dynamic>? get selectedBanner => _selectedBanner;

  void setSelectedBanner(Map<String, dynamic> banner) {
    _selectedBanner = banner;
    notifyListeners();
  }

  void navigateToBannerDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BannerDetailsPage()),
    );
  }
}
