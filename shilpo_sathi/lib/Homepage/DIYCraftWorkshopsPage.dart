import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DIYCraftWorkshopsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Text(
            "DIY Craft Workshops",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFF93DFD0).withOpacity(0.8),
              Colors.grey,
            ],
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 45),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.video_library, color: Colors.white),
                  onPressed: () async {
                    final Uri url = Uri.parse(youtubeLink);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw "Could not launch $youtubeLink";
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.group, color: Colors.white),
                  onPressed: () async {
                    final Uri url = Uri.parse(facebookLink);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw "Could not launch $facebookLink";
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
