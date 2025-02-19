import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'BannerSection.dart';
import 'CategorySection.dart';
import 'FeaturedArtisans.dart';
import 'LocationSection.dart';
import 'RecentlyAddedSection.dart';
import 'TrendingWorkshopsSection.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  final Color primaryColor = Color(0xFF26547D);
  final Color secondaryColor = Color(0xFFEF436B);
  final Color accentColor = Color(0xFFFFCE5C);
  final Color backgroundColor = Color(0xFFFFF5EB);
  final Color successColor = Color(0xFF05C793);

  String _currentAddress = "Fetching location...";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    _pageController = PageController(initialPage: 0);
    bool _isForward = true;
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          if (_isForward) {
            if (_currentPage < 3) {
              _currentPage++;
            } else {
              _isForward = false;
              _currentPage--;
            }
          } else {
            if (_currentPage > 0) {
              _currentPage--;
            } else {
              _isForward = true;
              _currentPage++;
            }
          }
          _pageController.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCirc,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _fetchLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentAddress = "Location services are disabled.";
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentAddress = "Location permissions are denied.";
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _currentAddress = "Location permissions are permanently denied.";
          _isLoading = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _currentAddress = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
          _isLoading = false;
        });
      } else {
        setState(() {
          _currentAddress = "Address not found.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _currentAddress = "Akhaliya, Sylhet: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F2E8),
      appBar: _buildAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocationSection(currentAddress: _currentAddress),
                  SizedBox(height: 20),
                  Text("Events Nearby You",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),),
                  SizedBox(height: 10),
                  BannerSection(pageController: _pageController),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Featured Artisans", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
                      TextButton(
                        onPressed: () {
                        },
                        child: Text("View all", style: TextStyle(color: secondaryColor)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  FeaturedArtisans(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
                      TextButton(
                        onPressed: () {
                        },
                        child: Text("View all", style: TextStyle(color: secondaryColor)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CategorySection(),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Trending Workshops", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
                      TextButton(
                        onPressed: () {
                        },
                        child: Text("View all", style: TextStyle(color: secondaryColor)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TrendingWorkshops(),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Recently Added", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
                      TextButton(
                        onPressed: () {
                        },
                        child: Text("View all", style: TextStyle(color: secondaryColor)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  RecentlyAdded(),
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
      backgroundColor: Color(0xFF6ECAB8),
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