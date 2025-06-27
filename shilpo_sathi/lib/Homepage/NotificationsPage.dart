import 'package:flutter/material.dart';
import 'package:shilpo_sathi/Homepage/notification_data.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Color(0xFF26547D),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF26547D),
                ),
              ),
              SizedBox(height: 20),

              // Show all login notifications dynamically
              for (var notif in loginNotifications)
                LoginNotification(
                  message: notif['message']!,
                  timestamp: notif['timestamp']!,
                ),

              SizedBox(height: 16),

              // You can keep these or remove as you want
              DataNotification(
                message: 'Your data usage has reached 80% of your limit.',
                timestamp: '2 hours ago',
              ),

              SizedBox(height: 16),

              OrderNotification(
                message: 'Your order #12345 has been shipped.',
                timestamp: '1 day ago',
              ),

              SizedBox(height: 16),

              SuggestionNotification(
                message: 'Check out our new collection of handmade crafts!',
                timestamp: '2 days ago',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataNotification extends StatelessWidget {
  final String message;
  final String timestamp;

  const DataNotification({
    required this.message,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return _buildNotificationCard(
      icon: Icons.data_usage,
      color: Colors.blue,
      message: message,
      timestamp: timestamp,
    );
  }
}

class LoginNotification extends StatelessWidget {
  final String message;
  final String timestamp;

  const LoginNotification({
    required this.message,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return _buildNotificationCard(
      icon: Icons.login,
      color: Colors.green,
      message: message,
      timestamp: timestamp,
    );
  }
}

class OrderNotification extends StatelessWidget {
  final String message;
  final String timestamp;

  const OrderNotification({
    required this.message,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return _buildNotificationCard(
      icon: Icons.shopping_cart,
      color: Colors.orange,
      message: message,
      timestamp: timestamp,
    );
  }
}

class SuggestionNotification extends StatelessWidget {
  final String message;
  final String timestamp;

  const SuggestionNotification({
    required this.message,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return _buildNotificationCard(
      icon: Icons.lightbulb_outline,
      color: Colors.purple,
      message: message,
      timestamp: timestamp,
    );
  }
}

Widget _buildNotificationCard({
  required IconData icon,
  required Color color,
  required String message,
  required String timestamp,
}) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.zero,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  timestamp,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
