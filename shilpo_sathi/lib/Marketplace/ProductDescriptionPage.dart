import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'MarketplacePage.dart' show Product;

class ProductDescriptionPage extends StatefulWidget {
  final Product product;

  ProductDescriptionPage({required this.product});

  @override
  _ProductDescriptionPageState createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  final TextEditingController _reviewController = TextEditingController();

  void _submitReview() {
    if (_reviewController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted successfully!')),
      );
      _reviewController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please write a review before submitting.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String locationImageUrl = 'https://via.placeholder.com/400x200';
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        widget.product.imageUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width - 32,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.product.price,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Product Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child: Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                      },
                      child: Text('Artisan Story'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Location
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () async {
                      final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(widget.product.location)}';
                      if (await canLaunch(googleMapsUrl)) {
                        await launch(googleMapsUrl);
                      } else {
                        throw 'Could not launch $googleMapsUrl';
                      }
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey),
                        image: DecorationImage(
                          image: NetworkImage(locationImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            widget.product.location,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Seller Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                    ),
                    title: Text(widget.product.sellerName),
                    subtitle: Text('Contact: ${widget.product.sellerContact}'),
                    trailing: Icon(Icons.star, color: Colors.amber),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Customer Reviews',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                        ),
                        title: Text('Customer Name'),
                        subtitle: Text('Great product! Highly recommended.'),
                        trailing: Icon(Icons.star, color: Colors.amber),
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Write a Review',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _reviewController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Write your review here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitReview,
                    child: Text('Submit Review'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
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