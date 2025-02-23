import 'package:flutter/material.dart';

class SignOutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout, color: Colors.red),
      title: Text(
        'Sign Out',
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {
        _showSignOutConfirmationDialog(context);
      },
    );
  }

  void _showSignOutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showSignOutSuccessDialog(context);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showSignOutSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Successfully Signed Out"),
          content: Icon(Icons.check_circle, color: Colors.red, size: 50),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/sign_in');
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
