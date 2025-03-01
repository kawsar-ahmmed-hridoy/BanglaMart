import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Cart/CartProvider.dart';
import 'ArtisanStoryPage.dart';
import 'MarketplacePage.dart' show Product;

class ProductDescriptionPage extends ConsumerStatefulWidget {
  final Product product;

  ProductDescriptionPage({required this.product});

  @override
  ConsumerState<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends ConsumerState<ProductDescriptionPage> {
  final TextEditingController _reviewController = TextEditingController();
  double _userRating = 0.0;
  final List<Map<String, dynamic>> _reviews = [];

  void _submitReview() {
    if (_reviewController.text.isNotEmpty && _userRating > 0) {
      setState(() {
        _reviews.add({
          'name': 'You',
          'rating': _userRating,
          'review': _reviewController.text,
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted successfully!')),
      );
      _reviewController.clear();
      _userRating = 0.0;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please write a review and provide a rating.')),
      );
    }
  }

  void _callSeller() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: widget.product.sellerContact);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  void _shareProduct() async {
    final String shareText =
        'Check out this product: ${widget.product.name} - ${widget.product.price}\n${widget.product.description}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Share functionality not implemented yet.')),
    );
  }

  final String locationImageUrl = 'https://via.placeholder.com/400x200';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6ECAB8),
        title: Text('Product Details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareProduct,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: PageView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        widget.product.imageUrl,
                        fit: BoxFit.cover,
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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(cartProvider.notifier).addToCart(widget.product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${widget.product.name} added to cart!')),
                            );
                          },
                          child: Text('Add to Cart'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArtisanStoryPage(
                                  artisanName: widget.product.sellerName,
                                  artisanContact: widget.product.sellerContact,
                                  artisanLocation: widget.product.location,
                                  artisanImageUrl: 'https://phantomhands.in/imager/media/the-practical-magic-of-the-nakshi-kantha-a-brief-introduction/23599/9-1_515cffaa34c7b727c9423a5db08aae1f.jpg',
                                  artisanHistory:
                                  'Meet ${widget.product.sellerName}, a skilled artisan from ${widget.product.location}. With years of experience in ${widget.product.category}, ${widget.product.sellerName} creates unique and high-quality products that reflect the rich cultural heritage of Bangladesh. Their work has been featured in numerous exhibitions and documentaries.',
                                  videoLink: 'https://youtu.be/zQrVKTnxMqo?si=rWcUoThnoazKJwAU',
                                  relatedLink: 'https://bn.wikipedia.org/wiki/%E0%A6%A8%E0%A6%95%E0%A6%B6%E0%A6%BF_%E0%A6%95%E0%A6%BE%E0%A6%81%E0%A6%A5%E0%A6%BE',
                                ),
                              ),
                            );
                          },
                          child: Text('Artisan Story'),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
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
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
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
                    trailing: IconButton(
                      icon: Icon(Icons.call, color: Colors.green),
                      onPressed: _callSeller,
                    ),
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
                    itemCount: _reviews.length,
                    itemBuilder: (context, index) {
                      final review = _reviews[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                          ),
                          title: Text(review['name']),
                          subtitle: Text(review['review']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (i) {
                              return Icon(
                                i < review['rating'] ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                              );
                            }),
                          ),
                        ),
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
                  Row(
                    children: [
                      Text('Your Rating: '),
                      SizedBox(width: 5.0),
                      ...List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _userRating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            setState(() {
                              _userRating = index + 1.0;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _reviewController,
                    maxLines: 2,
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
                      backgroundColor: Colors.grey,
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