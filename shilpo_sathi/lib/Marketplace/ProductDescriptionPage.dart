import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Account/MessagePage.dart';
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

  get product => null;
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

  void _openMessagePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MessagePage()),
    );
  }

  void _shareProduct() async {
    // Placeholder for share feature, not implemented yet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality not implemented yet.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                child: Image.asset(
                  widget.product.imageAsset,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('৳'+widget.product.price, style: const TextStyle(fontSize: 20, color: Colors.teal)),
            const SizedBox(height: 16),
            const Text('Product Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(widget.product.description, style: TextStyle(fontSize: 15)),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      cartProvider.addToCar2(product);
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
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                      side: const BorderSide(color: Colors.orangeAccent),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ArtisanStoryPage(
                          artisanName: widget.product.name,
                          artisanContact: widget.product.sellerContact,
                          artisanLocation: widget.product.location,
                          artisanImageUrl: widget.product.imageAsset,
                          sellerName: widget.product.sellerName,
                          artisanHistory: widget.product.history,
                          videoLink: widget.product.videoLink,
                          relatedLink: widget.product.relatedLink,
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
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage('assets/images/loc.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
              ),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7BF4D7).withOpacity(0.9),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    final String googleMapsUrl =
                        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(widget.product.location)}';
                    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
                      await launchUrl(Uri.parse(googleMapsUrl));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open map.')),
                      );
                    }
                  },
                  child: const Text('View on map', style: TextStyle(fontSize: 14)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Seller Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ListTile(
              leading: const CircleAvatar(backgroundImage: AssetImage('assets/images/hridoy.jpg')),
              title: Text(widget.product.sellerName),
              subtitle: Text('${widget.product.sellerContact}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: _callSeller,
                  ),
                  IconButton(
                    icon: Icon(Icons.message, color: Colors.deepPurple),
                    onPressed: () {
                      final sellerUser = {
                        'userId': widget.product.sellerContact,
                        'firstName': widget.product.sellerName,
                        'lastName': '',
                        'profileImage': 'assets/images/hridoy.jpg',
                      };
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MessagePage(initialUser: sellerUser),
                        ),
                      );
                    },
                  )
                ],
              ),
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
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Submit Review'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

extension on StateNotifierProvider<CartNotifier, List<CartItem>> {
  void addToCar2(product) {

  }
}
