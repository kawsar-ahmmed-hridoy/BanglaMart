import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ArtisanStoryPage extends StatefulWidget {
  final String artisanName;
  final String artisanContact;
  final String artisanLocation;
  final String artisanImageUrl;
  final String artisanHistory;
  final String videoLink;
  final String relatedLink;
  final String sellerName;

  ArtisanStoryPage({
    required this.artisanName,
    required this.artisanContact,
    required this.artisanLocation,
    required this.artisanImageUrl,
    required this.artisanHistory,
    required this.videoLink,
    required this.relatedLink,
    required this.sellerName,
  });

  @override
  _ArtisanStoryPageState createState() => _ArtisanStoryPageState();
}

class _ArtisanStoryPageState extends State<ArtisanStoryPage> {
  late YoutubePlayerController _controller;
  late String videoId;

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.videoLink) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch the link.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6ECAB8),
        title: Text('Artisan Story'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 28, color: Colors.teal),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Artisan: ${widget.artisanName}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.storefront, color: Colors.deepPurple),
                    SizedBox(width: 10),
                    Text('Seller: ${widget.sellerName}', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.green),
                    SizedBox(width: 10),
                    Text(widget.artisanContact, style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(widget.artisanLocation, style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                Text('History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  widget.artisanHistory,
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                SizedBox(height: 20),
                Divider(),
                Text('Video/Documentary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                if (videoId.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Color(0xFF6ECAB8),
                    ),
                  )
                else
                  Text('No video available.'),
                SizedBox(height: 20),
                Divider(),
                Row(
                  children: [
                    Icon(Icons.language, color: Colors.blue),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () => _launchUrl(widget.relatedLink),
                      child: Text(
                        'Browse Related Link',
                        style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text(
                  'Thank you for exploring this artisan’s story. Supporting local craftsmanship helps preserve tradition and empower communities.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
