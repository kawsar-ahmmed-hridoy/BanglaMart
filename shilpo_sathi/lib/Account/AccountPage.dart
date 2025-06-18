import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SignOutSection.dart';
import 'SocialAccountsPage.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String firstName = "Kawsar Ahmmed";
  String lastName = "Hridoy";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          // Debug: Print the entire document data
          print("User Document Data: ${userDoc.data()}");

          // Check if the fields exist and are not null
          setState(() {
            firstName = userDoc['firstName'] ?? "First Name Not Found";
            lastName = userDoc['lastName'] ?? "Last Name Not Found";
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          print("User document does not exist.");
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print("Error fetching user data: $e");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print("No user is currently logged in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: Color(0xFF252C35),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/my_profile');
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                      AssetImage('assets/images/hridoy.jpg'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$firstName $lastName',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              '5.0',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.post_add_rounded, color: Colors.deepPurple),
              title: Text('My posts'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.message, color: Colors.deepPurple),
              title: Text('Messages'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_rounded, color: Colors.deepPurple),
              title: Text('My orders'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.edit_location_alt_rounded, color: Colors.deepPurple),
              title: Text('Address book'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard_rounded, color: Colors.deepPurple),
              title: Text('Gift cards & vouchers'),
              onTap: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/need_help');
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.security, color: Colors.deepPurple, size: 20),
                              SizedBox(height: 10),
                              Text(
                                'Need help?',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Ask anything in help center.\n',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/privacy_checkup');
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.privacy_tip, color: Colors.deepPurple, size: 20),
                              SizedBox(height: 10),
                              Text(
                                'Privacy checkup',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Take an interactive tour of your privacy settings',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.share, color: Colors.deepPurple),
              title: Text('Social Accounts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SocialAccountsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.work, color: Colors.deepPurple),
              title: Text('Tell us what you think?'),
              onTap: () {
                Navigator.pushNamed(context, '/what_u_think');
              },
            ),
            ListTile(
              leading: Icon(Icons.manage_accounts, color: Colors.deepPurple),
              title: Text('Manage শিল্পসাথী account'),
              onTap: () {
                Navigator.pushNamed(context, '/manage_account');
              },
            ),
            SignOutSection(),
            Text("©2025 শিল্পসাথী (version 1.0) || All rights reserved", style: TextStyle(fontSize: 8)),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}