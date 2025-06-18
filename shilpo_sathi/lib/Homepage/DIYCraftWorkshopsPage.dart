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
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            children: [
              _buildWorkshopCard(
                "Pottery Workshop",
                "assets/images/pottery_workshop.jpg",
                "Learn the art of pottery from experts.",
                "https://youtu.be/D7K0H5GoERg?si=8Nx5JfIgmrB0bdmj",
                "https://www.facebook.com/groups/potteryworkshop",
              ),
              _buildWorkshopCard(
                "Textile Weaving",
                "assets/images/textile_weaving.jpg",
                "Discover traditional weaving techniques.",
                "https://www.youtube.com/watch?v=example2",
                "https://www.facebook.com/groups/textileweaving",
              ),
              _buildWorkshopCard(
                "Jewelry Making",
                "assets/images/jewelry_making.jpg",
                "Create your own handmade jewelry.",
                "https://www.youtube.com/watch?v=example3",
                "https://www.facebook.com/groups/jewelrymaking",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkshopCard(
      String title,
      String imagePath,
      String description,
      String youtubeLink,
      String facebookLink,
      ) {
    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Blurred glass effect
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.2),
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
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _iconButton(
                        Icons.ondemand_video,
                        youtubeLink,
                        Colors.redAccent,
                      ),
                      const SizedBox(width: 10),
                      _iconButton(
                        Icons.group,
                        facebookLink,
                        Colors.blueAccent,
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
          border: Border.all(color: Colors.white30),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
