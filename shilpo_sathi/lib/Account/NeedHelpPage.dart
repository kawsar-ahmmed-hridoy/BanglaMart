import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedHelpPage extends StatelessWidget {
  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'kawsarhridoy0146@gmail.com',
      query: 'subject=Need%20Help&body=Describe%20your%20issue%20here.',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  void _openFaqPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FAQPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        title: const Text('Need Help?'),
        elevation: 0,
        backgroundColor: const Color(0xFF1E2A38),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we assist you?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E2A38),
              ),
            ),
            const SizedBox(height: 24),
            HelpTile(
              icon: Icons.mail_outline,
              title: 'Contact Support',
              subtitle: 'Get in touch with our support team.',
              iconBgColor: Colors.indigo,
              onTap: _launchEmail,
            ),
            HelpTile(
              icon: Icons.help_outline,
              title: 'FAQs',
              subtitle: 'Find answers to common questions.',
              iconBgColor: Colors.blueGrey,
              onTap: () => _openFaqPage(context),
            ),
            HelpTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              subtitle: 'Understand how we protect your data.',
              iconBgColor: Colors.teal[600]!,
              onTap: () async {
                const url = 'https://your-privacy-policy-link.com';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HelpTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBgColor;
  final VoidCallback onTap;

  const HelpTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 1.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconBgColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconBgColor, size: 28),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I reset my password?',
      'answer':
      'Go to Account > Privacy Checkup > Change Password to update your credentials.'
    },
    {
      'question': 'How do I contact a seller?',
      'answer':
      'Visit the product description page and find the seller\'s contact options.'
    },
    {
      'question': 'How do I delete my account?',
      'answer':
      'Go to Manage Account > Delete Account or contact support for further assistance.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        title: const Text('FAQs'),
        backgroundColor: const Color(0xFF1E2A38),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final item = faqs[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              tilePadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              title: Text(
                item['question']!,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15.5),
              ),
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    item['answer']!,
                    style: TextStyle(color: Colors.grey[800], fontSize: 14),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
