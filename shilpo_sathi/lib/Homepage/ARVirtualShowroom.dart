import 'package:flutter/material.dart';
import 'ARVirtualShowroomPage.dart';

class ARVirtualShowroom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ARVirtualShowroomPage(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('assets/ar_showroom.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            'Explore AR Showroom',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}