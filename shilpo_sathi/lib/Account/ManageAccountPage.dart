import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  void toggleTheme(bool isDark) {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}

class ManageAccountPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Bangla Mart Account'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete Account'),
              subtitle: Text('Permanently delete your account and all data.'),
              onTap: () {
                _showDeleteAccountDialog(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.brightness_6, color: Colors.blue),
              title: Text('Theme'),
              subtitle: Text('Switch between dark and light mode.'),
              trailing: Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).toggleTheme(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteAccount(context);
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account deleted successfully.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushNamedAndRemoveUntil(context, '/sign_in', (route) => false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete account. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error deleting account: $e');
    }
  }
}