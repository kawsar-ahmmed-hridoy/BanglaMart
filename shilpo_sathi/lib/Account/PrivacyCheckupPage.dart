import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrivacyCheckupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Privacy Checkup'),
    ),
    body: ListView(padding: EdgeInsets.all(16), children: [
      Text(
        'Review and manage your privacy settings to control how your information is used and shared.',
        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
      ),
      SizedBox(height: 10),
      SectionCard(
        icon: Icons.lock_outline,
        color: Colors.deepPurple,
        title: 'Account Security',
        children: [ChangePasswordTile()],
      ),
      SectionCard(
        icon: Icons.shield_outlined,
        color: Colors.green,
        title: 'Data Permissions',
        children: [DataPermissionsTile()],
      ),
      SizedBox(height: 20),
      Text(
        'Updated: June 2025',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      ),
    ]),
  );
}

class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final IconData icon;
  final Color color;

  SectionCard({required this.title, required this.children, required this.icon, required this.color});

  @override
  Widget build(BuildContext c) => Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    margin: EdgeInsets.symmetric(vertical: 12),
    elevation: 3,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Icon(icon, size: 28, color: color),
            SizedBox(width: 12),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        Divider(),
        ...children,
      ]),
    ),
  );
}

class ChangePasswordTile extends StatefulWidget {
  @override
  _ChangePasswordTileState createState() => _ChangePasswordTileState();
}

class _ChangePasswordTileState extends State<ChangePasswordTile> {
  final _oldCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  bool _loading = false;

  Future<void> updatePassword() async {
    final user = FirebaseAuth.instance.currentUser!;
    final creds = EmailAuthProvider.credential(email: user.email!, password: _oldCtrl.text.trim());
    setState(() => _loading = true);
    try {
      await user.reauthenticateWithCredential(creds);
      await user.updatePassword(_newCtrl.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password updated successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext ctx) => ListTile(
    leading: Icon(Icons.lock_reset),
    title: Text('Change Password'),
    subtitle: _loading
        ? LinearProgressIndicator()
        : Text('Tap to change your password securely.'),
    onTap: () => showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text('Change Password'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: _oldCtrl, decoration: InputDecoration(labelText: 'Old Password'), obscureText: true),
          TextField(controller: _newCtrl, decoration: InputDecoration(labelText: 'New Password'), obscureText: true),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                updatePassword();
              },
              child: Text('Update')),
        ],
      ),
    ),
  );
}

class DataPermissionsTile extends StatefulWidget {
  @override
  _DataPermissionsTileState createState() => _DataPermissionsTileState();
}

class _DataPermissionsTileState extends State<DataPermissionsTile> {
  List<UserInfo> providers = [];

  @override
  void initState() {
    super.initState();
    providers = FirebaseAuth.instance.currentUser!.providerData;
  }

  Future<void> unlink(String providerId) async {
    await FirebaseAuth.instance.currentUser!.unlink(providerId);
    setState(() => providers = FirebaseAuth.instance.currentUser!.providerData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unlinked $providerId')));
  }

  @override
  Widget build(BuildContext ctx) => Column(
    children: providers.map((p) {
      return ListTile(
        leading: Icon(Icons.link_off),
        title: Text(p.providerId),
        subtitle: Text(p.uid ?? 'Unknown UID'),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          child: Text('Unlink'),
          onPressed: providers.length > 1 ? () => unlink(p.providerId) : null,
        ),
      );
    }).toList(),
  );
}
