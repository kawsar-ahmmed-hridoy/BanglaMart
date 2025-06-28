import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Cart/CartProvider.dart';
import '../Marketplace/MarketplacePage.dart';
import '../Marketplace/ProductDescriptionPage.dart';

class Featuredartisan extends ConsumerWidget {
  final List<Product> featuredArtisans = [
    Product(
      name: 'বেতের ঝুড়ি',
      price: '৳250',
      imageAsset: 'assets/images/7.jpg',
      description: '১০০% হাতে তৈরি, সূক্ষ্ম নকশা ও সূচিকর্ম, ফুল, লতা, পশু, পাখি, ধর্মীয় প্রতীক, গ্রামীণ জীবনচিত্রসহ নানা রকম বিষয়বস্তু চিত্রিত।',
      sellerName: 'রাকিব',
      sellerContact: '+880163456789',
      location: 'Natore, Rajshahi, Bangladesh',
      category: 'Weaving',
      videoLink: 'https://youtu.be/Lvy6ctRypNI?si=Kms5E62fei5OG3vc',
      history: 'নকশীকাঁথার ইতিহাস প্রায় ১০০০ বছরের পুরনো। এই শিল্পের প্রথম পরিচিতি পাওয়া যায় প্রাচীন বাঙালি কবিতা ও সাহিত্যে। বিশেষ করে "নকশীকাঁথার মাঠ" কাব্যে জসীমউদ্দীন এই শিল্পের অসাধারণ বর্ণনা দিয়েছেন।'
          'মূলত বাঙালি গৃহিণীরা ঘরের পুরনো কাপড়, ধুতি বা শাড়ি পুনর্ব্যবহার করে কাঁথা তৈরি করতেন। পরে তাদের সৃজনশীলতা ও কল্পনার ছোঁয়ায় এগুলো হয়ে ওঠে জীবন্ত শিল্পকর্ম। এটি শুধু ব্যবহারিক জিনিস নয় বরং ঐতিহ্য, সংস্কৃতি ও নারীর আত্মপ্রকাশের প্রতীক।'
          'প্রসিদ্ধ স্থানসমূহ (Famous Regions): জামালপুর, যশোর, কুমিল্লা রাজশাহী ফরিদপুর এই অঞ্চলগুলোতে নকশীকাঁথা তৈরির প্রচলন সবচেয়ে বেশি। নকশীকাঁথা এখন দেশ-বিদেশে একটি জনপ্রিয় উপহার সামগ্রী হিসেবে বিবেচিত। এটি ঐতিহ্য ও আধুনিকতার এক অনন্য সংমিশ্রণ।',
      relatedLink: 'https://en.wikipedia.org/wiki/Nakshi_Kantha',
    ),
    Product(
      name: 'পাটের ব্যাগ',
      price: '৳500',
      imageAsset: 'assets/images/8.jpg',
      description: 'সম্পূর্ণ হাতে বোনা, সূক্ষ্ম ও জটিল নকশা, যেমন ফুল, পাখি, জ্যামিতিক ধরণ, নরম ও আরামদায়ক।',
      sellerName: 'সুমন',
      sellerContact: '+880187654321',
      location: 'Tangail, Dhaka, Bangladesh',
      category: 'Clothing',
      videoLink: 'https://youtu.be/B9ZpB6L493c?si=OQDBn3yAeingDPBm',
      history: 'জামদানি শাড়ির উৎপত্তি বহু পুরনো, যা মোগল আমলের সময় বাংলায় প্রচলিত ছিল। এই শিল্পকর্মের উৎপত্তি প্রাচীন বাঙালি ও পারস্য-আরব বুনন ঐতিহ্যের মিশ্রণ। জামদানি বুনন মূলত ঢাকার আশেপাশে গড়ে উঠেছিল, বিশেষ করে মুন্সিগঞ্জ ও নারায়ণগঞ্জ অঞ্চলে। এটি বিশ্বে বাঙালির অন্যতম গর্বের ঐতিহ্য।'
          'বাংলাদেশের জামদানি শাড়ি ২০১৩ সালে ইউনেস্কো’র মানবসৃষ্ট অমূর্ত সাংস্কৃতিক ঐতিহ্য হিসেবে স্বীকৃত হয়।'
          'প্রসিদ্ধ অঞ্চল (Famous Regions): ঢাকা, নারায়ণগঞ্জ, মুন্সিগঞ্জ'
          'জামদানি শাড়ি সাধারণত উৎসব, বিয়ের অনুষ্ঠান ও বিশেষ দিনে পরিধান করা হয়। এটি বাঙালির ঐতিহ্যবাহী সংস্কৃতির প্রতীক এবং গৌরবের একটি নিদর্শন।',
      relatedLink: 'https://bn.wikipedia.org/wiki/%E0%A6%9C%E0%A6%BE%E0%A6%AE%E0%A6%A6%E0%A6%BE%E0%A6%A8%E0%A6%BF',
    ),
    Product(
      name: 'জামদানি শাড়ি',
      price: '৳2500',
      imageAsset: 'assets/images/9.jpg',
      description: 'সম্পূর্ণ হাতে বোনা, সূক্ষ্ম ও জটিল নকশা, যেমন ফুল, পাখি, জ্যামিতিক ধরণ, নরম ও আরামদায়ক।',
      sellerName: 'সুমন',
      sellerContact: '+880187654321',
      location: 'Tangail, Dhaka, Bangladesh',
      category: 'Clothing',
      videoLink: 'https://youtu.be/B9ZpB6L493c?si=OQDBn3yAeingDPBm',
      history: 'জামদানি শাড়ির উৎপত্তি বহু পুরনো, যা মোগল আমলের সময় বাংলায় প্রচলিত ছিল। এই শিল্পকর্মের উৎপত্তি প্রাচীন বাঙালি ও পারস্য-আরব বুনন ঐতিহ্যের মিশ্রণ। জামদানি বুনন মূলত ঢাকার আশেপাশে গড়ে উঠেছিল, বিশেষ করে মুন্সিগঞ্জ ও নারায়ণগঞ্জ অঞ্চলে। এটি বিশ্বে বাঙালির অন্যতম গর্বের ঐতিহ্য।'
          'বাংলাদেশের জামদানি শাড়ি ২০১৩ সালে ইউনেস্কো’র মানবসৃষ্ট অমূর্ত সাংস্কৃতিক ঐতিহ্য হিসেবে স্বীকৃত হয়।'
          'প্রসিদ্ধ অঞ্চল (Famous Regions): ঢাকা, নারায়ণগঞ্জ, মুন্সিগঞ্জ'
          'জামদানি শাড়ি সাধারণত উৎসব, বিয়ের অনুষ্ঠান ও বিশেষ দিনে পরিধান করা হয়। এটি বাঙালির ঐতিহ্যবাহী সংস্কৃতির প্রতীক এবং গৌরবের একটি নিদর্শন।',
      relatedLink: 'https://bn.wikipedia.org/wiki/%E0%A6%9C%E0%A6%BE%E0%A6%AE%E0%A6%A6%E0%A6%BE%E0%A6%A8%E0%A6%BF',
    ),
    Product(
      name: 'নকশীকাঁথা',
      price: '৳1550',
      imageAsset: 'assets/images/1.jpg',
      description: '১০০% হাতে তৈরি, সূক্ষ্ম নকশা ও সূচিকর্ম, ফুল, লতা, পশু, পাখি, ধর্মীয় প্রতীক, গ্রামীণ জীবনচিত্রসহ নানা রকম বিষয়বস্তু চিত্রিত।',
      sellerName: 'রাকিব',
      sellerContact: '+880163456789',
      location: 'Natore, Rajshahi, Bangladesh',
      category: 'Weaving',
      videoLink: 'https://youtu.be/Lvy6ctRypNI?si=Kms5E62fei5OG3vc',
      history: 'নকশীকাঁথার ইতিহাস প্রায় ১০০০ বছরের পুরনো। এই শিল্পের প্রথম পরিচিতি পাওয়া যায় প্রাচীন বাঙালি কবিতা ও সাহিত্যে। বিশেষ করে "নকশীকাঁথার মাঠ" কাব্যে জসীমউদ্দীন এই শিল্পের অসাধারণ বর্ণনা দিয়েছেন।'
          'মূলত বাঙালি গৃহিণীরা ঘরের পুরনো কাপড়, ধুতি বা শাড়ি পুনর্ব্যবহার করে কাঁথা তৈরি করতেন। পরে তাদের সৃজনশীলতা ও কল্পনার ছোঁয়ায় এগুলো হয়ে ওঠে জীবন্ত শিল্পকর্ম। এটি শুধু ব্যবহারিক জিনিস নয় বরং ঐতিহ্য, সংস্কৃতি ও নারীর আত্মপ্রকাশের প্রতীক।'
          'প্রসিদ্ধ স্থানসমূহ (Famous Regions): জামালপুর, যশোর, কুমিল্লা রাজশাহী ফরিদপুর এই অঞ্চলগুলোতে নকশীকাঁথা তৈরির প্রচলন সবচেয়ে বেশি। নকশীকাঁথা এখন দেশ-বিদেশে একটি জনপ্রিয় উপহার সামগ্রী হিসেবে বিবেচিত। এটি ঐতিহ্য ও আধুনিকতার এক অনন্য সংমিশ্রণ।',
      relatedLink: 'https://en.wikipedia.org/wiki/Nakshi_Kantha',
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
          height: 210,
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
