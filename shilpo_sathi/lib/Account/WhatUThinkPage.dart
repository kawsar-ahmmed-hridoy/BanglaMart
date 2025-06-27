import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatYouThinkPage extends StatefulWidget {
  @override
  _WhatYouThinkPageState createState() => _WhatYouThinkPageState();
}

class _WhatYouThinkPageState extends State<WhatYouThinkPage> {
  final TextEditingController _controller = TextEditingController();
  bool isSending = false;

  Future<void> _sendFeedback(String message) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'kawsarhridoy0146@gmail.com',
      queryParameters: {
        'subject': 'User Feedback for Bangla Mart',
        'body': message,
      },
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch email app')),
      );
    }
  }

  void _showReviewDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: const [
              Icon(Icons.feedback, color: Colors.orange),
              SizedBox(width: 8),
              Text('Your Feedback'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Let us know what you think about the app.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your feedback here...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                final message = _controller.text.trim();
                if (message.isNotEmpty) {
                  Navigator.pop(context);
                  _controller.clear();
                  await _sendFeedback(message);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your feedback before sending.')),
                  );
                }
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tell us what you think?', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.rate_review, color: Colors.cyan, size: 70),
              const SizedBox(height: 20),
              const Text(
                'We value your thoughts',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your feedback helps us improve the experience of using our app.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text('Write a Review', style: TextStyle(fontSize: 16)),
                onPressed: _showReviewDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
