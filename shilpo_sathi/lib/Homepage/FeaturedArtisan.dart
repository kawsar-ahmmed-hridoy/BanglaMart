import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Cart/CartProvider.dart';
import '../Marketplace/MarketplacePage.dart';
import '../Marketplace/ProductDescriptionPage.dart';

class Featuredartisan extends ConsumerWidget {
  final List<Product> featuredArtisans = [
    Product(
      name: 'Jamdani Sharee',
      price: '\৳50',
      imageAsset: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwrNhEl0ObNXh0IgGO7T3K5rQLVAz3U6sxwttLoTzwj5-AmGHW4lAJqV0XTU2jU8wBkiY&usqp=CAU',
      description: 'A Share.',
      sellerName: 'Artisan 2',
      sellerContact: '+880987654321',
      location: 'Tangail, Dhaka, Bangladesh',
      category: 'Clothing',
      videoLink: 'https://www.youtube.com/watch?v=jamdani_demo',
      history: 'জামদানি শাড়ি মুঘল আমল থেকে শুরু করে আজ পর্যন্ত বাংলার গর্ব। এটি একটি জটিল হস্তচালিত তাঁত যা বিশ্ববিখ্যাত।',
      relatedLink: 'https://en.wikipedia.org/wiki/Jamdani',
    ),
    Product(
      name: 'Jamdani Sharee',
      price: '\৳3500',
      imageAsset: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwrNhEl0ObNXh0IgGO7T3K5rQLVAz3U6sxwttLoTzwj5-AmGHW4lAJqV0XTU2jU8wBkiY&usqp=CAU',
      description: 'A Share.',
      sellerName: 'Artisan 2',
      sellerContact: '+880987654321',
      location: 'Tangail, Dhaka, Bangladesh',
      category: 'Clothing',
      videoLink: 'https://www.youtube.com/watch?v=jamdani_demo',
      history: 'জামদানি শাড়ি মুঘল আমল থেকে শুরু করে আজ পর্যন্ত বাংলার গর্ব। এটি একটি জটিল হস্তচালিত তাঁত যা বিশ্ববিখ্যাত।',
      relatedLink: 'https://en.wikipedia.org/wiki/Jamdani',
    ),
    Product(
      name: 'নকশি কাঁথা',
      price: '\৳1200',
      imageAsset: 'https://phantomhands.in/imager/media/the-practical-magic-of-the-nakshi-kantha-a-brief-introduction/23599/9-1_515cffaa34c7b727c9423a5db08aae1f.jpg',
      description: 'নকশি কাঁথা হলো সাধারণ কাঁথার উপর নানা ধরনের নকশা করে বানানো বিশেষ প্রকারের কাঁথা। নকশি কাঁথা শত শত বছরের পুরনো ভারতের পশ্চিমবঙ্গ ও বাংলাদেশের সংস্কৃতির একটা অংশ।',
      sellerName: 'Rahimul',
      sellerContact: '+880123456789',
      location: 'Natore, Rajshahi, Bangladesh',
      category: 'Handicraft',
      videoLink: 'https://www.youtube.com/watch?v=nokshi_demo',
      history: 'নকশি কাঁথার ইতিহাস শত বছরের পুরনো। এটি বাংলার নারীদের হাতে তৈরি এক অসাধারণ শিল্পকর্ম যা ঐতিহ্য ও সংস্কৃতিকে বহন করে।',
      relatedLink: 'https://en.wikipedia.org/wiki/Nakshi_Kantha',
    ),
    Product(
      name: 'Jamdani Sharee',
      price: '\৳2550',
      imageAsset: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwrNhEl0ObNXh0IgGO7T3K5rQLVAz3U6sxwttLoTzwj5-AmGHW4lAJqV0XTU2jU8wBkiY&usqp=CAU',
      description: 'A Share.',
      sellerName: 'Artisan 2',
      sellerContact: '+880987654321',
      location: 'Tangail, Dhaka, Bangladesh',
      category: 'Clothing',
      videoLink: 'https://www.youtube.com/watch?v=jamdani_demo',
      history: 'জামদানি শাড়ি মুঘল আমল থেকে শুরু করে আজ পর্যন্ত বাংলার গর্ব। এটি একটি জটিল হস্তচালিত তাঁত যা বিশ্ববিখ্যাত।',
      relatedLink: 'https://en.wikipedia.org/wiki/Jamdani',
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
          height: 210, // increased height to accommodate full content
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
        width: 170,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26.withOpacity(0.1),
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                //color: Colors.grey[100],
              ),
              clipBehavior: Clip.antiAlias,
              child: product.imageAsset.startsWith('http')
                  ? Image.network(
                product.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                ),
              )
                  : Image.asset(
                product.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  iconSize: 20,
                  color: Colors.red,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  iconSize: 20,
                  color: Colors.grey[600],
                  onPressed: () {
                    ref.read(cartProvider.notifier).addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart!')),
                    );
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
