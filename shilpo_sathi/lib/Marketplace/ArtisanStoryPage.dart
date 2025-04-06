import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ArtisanStoryPage extends StatefulWidget {
  final String artisanName;
  final String artisanContact;
  final String artisanLocation;
  final String artisanImageUrl;
  final String artisanHistory;
  final String videoLink;
  final String relatedLink;

  ArtisanStoryPage({
    required this.artisanName,
    required this.artisanContact,
    required this.artisanLocation,
    required this.artisanImageUrl,
    required this.artisanHistory,
    required this.videoLink,
    required this.relatedLink,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6ECAB8),
        title: Text('Artisan Story'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: widget.artisanImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.artisanName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.green),
                      SizedBox(width: 8.0),
                      Text(
                        widget.artisanContact,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 8.0),
                      Text(
                        widget.artisanLocation,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.artisanHistory,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Video/Documentary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  if (videoId.isNotEmpty)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Color(0xFF6ECAB8),
                        onReady: () {
                          print('Player is ready.');
                        },
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () async {
                        if (await canLaunch(widget.videoLink)) {
                          await launch(widget.videoLink);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error Occured.')),
                          );
                        }
                      },
                      child: Text(
                        widget.videoLink,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  SizedBox(height: 16.0),
                  Text(
                    'Related Links',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunch(widget.relatedLink)) {
                        await launch(widget.relatedLink);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Could not launch the related link.')),
                        );
                      }
                    },
                    child: Text(
                      widget.relatedLink,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final Uri phoneUri = Uri(scheme: 'tel', path: widget.artisanContact);
                        launch(phoneUri.toString());
                      },
                      child: Text('Call Artisan'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Color(0xFF6ECAB8),
                      ),
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
}