import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialAccountsPage extends StatefulWidget {
  @override
  _SocialAccountsPageState createState() => _SocialAccountsPageState();
}

class _SocialAccountsPageState extends State<SocialAccountsPage> {
  List<Map<String, String>> socialLinks = [
    {
      'name': 'Facebook',
      'url': 'https://www.facebook.com/kawsarahmmedhridoy0146',
      'icon': 'facebook',
    },
    {
      'name': 'Instagram',
      'url': 'https://www.instagram.com/hrid_oyee?igsh=aWRic2UyaDdxZGM3',
      'icon': 'instagram',
    },
  ];

  IconData _getIcon(String key) {
    switch (key) {
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt_rounded;
      case 'linkedin':
        return Icons.business_center_rounded;
      default:
        return Icons.link;
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _editAccount(int index) {
    final nameController =
    TextEditingController(text: socialLinks[index]['name']);
    final urlController =
    TextEditingController(text: socialLinks[index]['url']);
    final iconController =
    TextEditingController(text: socialLinks[index]['icon']);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: urlController, decoration: InputDecoration(labelText: 'URL')),
            TextField(controller: iconController, decoration: InputDecoration(labelText: 'Icon Key (e.g., facebook)')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                socialLinks[index] = {
                  'name': nameController.text,
                  'url': urlController.text,
                  'icon': iconController.text
                };
              });
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _addAccount() {
    final nameController = TextEditingController();
    final urlController = TextEditingController();
    final iconController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add New Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: urlController, decoration: InputDecoration(labelText: 'URL')),
            TextField(controller: iconController, decoration: InputDecoration(labelText: 'Icon Key')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                socialLinks.add({
                  'name': nameController.text,
                  'url': urlController.text,
                  'icon': iconController.text,
                });
              });
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _removeAccount(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Remove Account'),
        content: Text('Are you sure you want to remove this account?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                socialLinks.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Remove', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Accounts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: socialLinks.isEmpty
                ? Center(child: Text('No social accounts added yet.'))
                : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: socialLinks.length,
              itemBuilder: (context, index) {
                final item = socialLinks[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(_getIcon(item['icon'] ?? ''), color: Colors.deepPurple),
                    ),
                    title: Text(item['name'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item['url'] ?? '', style: TextStyle(color: Colors.grey[700])),
                    onTap: () => _launchURL(item['url'] ?? ''),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') _editAccount(index);
                        if (value == 'delete') _removeAccount(index);
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: Icon(Icons.add),
              label: Text('Add New Account', style: TextStyle(fontSize: 16)),
              onPressed: _addAccount,
            ),
          ),
        ],
      ),
    );
  }
}
