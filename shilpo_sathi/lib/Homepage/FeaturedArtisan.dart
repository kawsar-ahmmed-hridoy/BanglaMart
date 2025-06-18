import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Cart/CartProvider.dart';
import '../Marketplace/MarketplacePage.dart';
import '../Marketplace/ProductDescriptionPage.dart';

class Featuredartisan extends ConsumerWidget {
  final List<Product> featuredArtisans = [
    Product(
      name: 'Pottery Workshop',
      price: '\$20.99',
      imageUrl: 'assets/images/nakshikatha2.jpg',
      description: 'Handcrafted pottery with traditional Bangladeshi flair.',
      sellerName: 'Rahimul',
      sellerContact: '+880123456789',
      location: 'Natore, Rajshahi, Bangladesh',
      category: 'Handicraft',
    ),
    Product(
      name: 'Weaving Classes',
      price: '\$25.99',
      imageUrl: 'https://example.com/weaving.jpg',
      description: 'Join skilled artisans and learn traditional weaving.',
      sellerName: 'Jawad',
      sellerContact: '+880987654321',
      location: 'Tangail, Dhaka, Bangladesh',
      category: 'Clothing',
    ),
    Product(
      name: 'Jewelry Making',
      price: '\$30.99',
      imageUrl: 'https://example.com/jewelry.jpg',
      description: 'Unique handcrafted jewelry with heritage designs.',
      sellerName: 'Shawon',
      sellerContact: '+880192837465',
      location: 'Sylhet, Bangladesh',
      category: 'Accessories',
    ),
    Product(
      name: 'Wood Carving',
      price: '\$15.99',
      imageUrl: 'assets/images/nakshikatha2.jpg',
      description: 'Authentic wood carvings crafted by local artisans.',
      sellerName: 'Borson',
      sellerContact: '+8801122334455',
      location: 'Kushtia, Bangladesh',
      category: 'Woodwork',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: const [
              Text(
                "Featured Artisan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.auto_awesome, color: Colors.amber),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 230, // increased height to accommodate full content
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: featuredArtisans.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final product = featuredArtisans[index];
              return _buildArtisanCard(context, ref, product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildArtisanCard(BuildContext context, WidgetRef ref, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDescriptionPage(product: product)),
        );
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: product.imageUrl.startsWith('http')
                  ? Image.network(
                product.imageUrl,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 80,
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                ),
              )
                  : Image.asset(
                product.imageUrl,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text("👤 ${product.sellerName}",
                      style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  const SizedBox(height: 2),
                  Text("📍 ${product.location}",
                      style: const TextStyle(fontSize: 11, color: Colors.black45),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(product.price,
                      style: const TextStyle(fontSize: 14, color: Colors.teal, fontWeight: FontWeight.bold)),
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} added to cart!')),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined, size: 13, color: Colors.white),
                    label: const Text("Add to Cart", style: TextStyle(fontSize: 12, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEF436B),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      minimumSize: Size(90, 30),
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
