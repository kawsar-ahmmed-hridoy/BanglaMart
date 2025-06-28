import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

class DIYCraftWorkshopsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "DIY Craft Workshops",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            children: [
              _buildWorkshopCard(
                "নকশীকাঁথার ডিজাইন",
                "https://youtu.be/D7K0H5GoERg?si=8Nx5JfIgmrB0bdmj",
                "শিখুন কিভাবে শিল্পীরা নকশীকাঁথা তৈরি করে।",
                "https://youtu.be/D7K0H5GoERg?si=8Nx5JfIgmrB0bdmj",
                "https://www.facebook.com/share/g/1UL5enBUZ2/",
              ),
              _buildWorkshopCard(
                "জামদানি শাড়ি তৈরি",
                "https://youtu.be/AnVQS7qxhCE?si=xJJZps0trUZ6Ty9l",
                "জামদানি শাড়ি তৈরির টেকনিক শিখুন।",
                "https://youtu.be/AnVQS7qxhCE?si=xJJZps0trUZ6Ty9l",
                "https://www.facebook.com/share/g/18yAdkQFJh/",
              ),
              _buildWorkshopCard(
                "শখের মৃৎশিল্প",
                "https://youtu.be/pdCdk59KG84?si=3yiW0pP3n1CWDRS5",
                "মাটির কারিগর ও কারুকাজের বিস্তারিত।",
                "https://youtu.be/pdCdk59KG84?si=3yiW0pP3n1CWDRS5",
                "https://www.facebook.com/share/g/19RE22E5UB/",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkshopCard(
      String title,
      String youtubeLinkForThumbnail,
      String description,
      String youtubeLink,
      String facebookLink,
      ) {
    final videoId = _extractYoutubeVideoId(youtubeLinkForThumbnail);

    final thumbnailUrl = videoId != null
        ? "https://img.youtube.com/vi/$videoId/hqdefault.jpg"
        : null;

    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.indigoAccent.withOpacity(0.3),
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: thumbnailUrl != null
                  ? Image.network(
                thumbnailUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 50),
                    ),
                  );
                },
              )
                  : Container(color: Colors.grey.shade300),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.1),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Container(color: Colors.black.withOpacity(0.1)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.cyanAccent,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      _iconButton(
                        Icons.ondemand_video,
                        youtubeLink,
                        Colors.yellow,
                      ),
                      const SizedBox(width: 10),
                      _iconButton(
                        Icons.group,
                        facebookLink,
                        Colors.cyanAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _extractYoutubeVideoId(String url) {
    try {
      final uri = Uri.parse(url);

      if (uri.host.contains("youtu.be")) {
        return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
      }

      if (uri.host.contains("youtube.com")) {
        return uri.queryParameters['v'];
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Widget _iconButton(IconData icon, String link, Color color) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri.parse(link);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          debugPrint("Could not launch $link");
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
