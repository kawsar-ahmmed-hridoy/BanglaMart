import 'package:flutter/material.dart';

class LocationSection extends StatelessWidget {
  final String currentAddress;

  LocationSection({required this.currentAddress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: Color(0xFF26547D)),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            currentAddress,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}