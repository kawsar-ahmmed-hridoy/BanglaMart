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
  final String locationImageUrl = 'https://via.placeholder.com/400x200';

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
        const SnackBar(content: Text('Review submitted successfully!')),
      );
      _reviewController.clear();
      _userRating = 0.0;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write a review and provide a rating.')),
      );
    }
  }

  void _callSeller() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: widget.product.sellerContact);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _shareProduct() async {
    final String shareText =
        'Check out this product: ${widget.product.name} - ${widget.product.price}\n${widget.product.description}';
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality not implemented yet.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF252C35),
        title: const Text('Product Details', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _shareProduct),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 230,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(widget.product.imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, size: 8, color: Colors.white70),
                        SizedBox(width: 4),
                        Icon(Icons.circle, size: 8, color: Colors.white38),
                        SizedBox(width: 4),
                        Icon(Icons.circle, size: 8, color: Colors.white38),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(widget.product.price, style: const TextStyle(fontSize: 20, color: Colors.teal)),
            const SizedBox(height: 16),
            const Text('Product Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(widget.product.description, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(widget.product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${widget.product.name} added to cart!')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.person),
                    label: const Text('Artisan Story'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.teal),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ArtisanStoryPage(
                          artisanName: widget.product.sellerName,
                          artisanContact: widget.product.sellerContact,
                          artisanLocation: widget.product.location,
                          artisanImageUrl: widget.product.imageUrl,
                          artisanHistory: 'Meet ${widget.product.sellerName}, a skilled artisan from ${widget.product.location}...',
                          videoLink: 'https://youtu.be/zQrVKTnxMqo?si=rWcUoThnoazKJwAU',
                          relatedLink: 'https://bn.wikipedia.org/wiki/%E0%A6%A8%E0%A6%95%E0%A6%B6%E0%A6%BF_%E0%A6%95%E0%A6%BE%E0%A6%81%E0%A6%A5%E0%A6%BE',
                        )),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final String googleMapsUrl =
                    'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(widget.product.location)}';
                if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
                  await launchUrl(Uri.parse(googleMapsUrl));
                }
              },
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: NetworkImage(locationImageUrl), fit: BoxFit.cover),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      widget.product.location,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Seller Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ListTile(
              leading: const CircleAvatar(backgroundImage: NetworkImage('https://via.placeholder.com/150')),
              title: Text(widget.product.sellerName),
              subtitle: Text('Contact: ${widget.product.sellerContact}'),
              trailing: IconButton(icon: const Icon(Icons.call, color: Colors.green), onPressed: _callSeller),
            ),
            const SizedBox(height: 20),
            const Text('Customer Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ..._reviews.map((review) => Card(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                leading: const CircleAvatar(backgroundImage: NetworkImage('https://via.placeholder.com/150')),
                title: Text(review['name']),
                subtitle: Text(review['review']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (i) => Icon(
                    i < review['rating'] ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  )),
                ),
              ),
            )),
            const SizedBox(height: 20),
            const Text('Write a Review', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Your Rating: ', style: TextStyle(fontWeight: FontWeight.w500)),
                ...List.generate(5, (index) => IconButton(
                  icon: Icon(
                    index < _userRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _userRating = index + 1.0;
                    });
                  },
                )),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Write your thoughts...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Submit Review'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _submitReview,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
