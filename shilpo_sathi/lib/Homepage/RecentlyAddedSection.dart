import 'package:flutter/material.dart';

class RecentlyAdded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF05C793).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New Pottery Workshop",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF26547D)),
          ),
          SizedBox(height: 5),
          Text(
            "Join our new pottery workshop and learn the art of clay modeling.",
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
            },
            child: Text("View Details", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFEF436B)),
          ),
        ],
      ),
    );
  }
}