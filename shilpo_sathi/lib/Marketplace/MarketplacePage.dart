import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Cart/CartProvider.dart';
import '../Cart/FilteredProductsProvider.dart';
import 'AddPostPage.dart';
import 'FavoritesPage.dart';
import 'ProductDescriptionPage.dart';

String formatTaka(String price) {
  final clean = price.replaceAll(RegExp(r'[^0-9.]'), '');
  final value = double.tryParse(clean) ?? 0.0;
  return '৳${value.toStringAsFixed(2)}';
}

class MarketplacePage extends ConsumerWidget {
  final List<Product> products = [
    Product(
      name: 'নকশীকাঁথা (Nakshi Kantha)',
      price: '1550',
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
    Product(
      name: 'জামদানি শাড়ি (Jamdani Sharee)',
      price: '2500',
      imageAsset: 'assets/images/2.jpg',
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
      name: 'মৃৎশিল্প (Pottery)',
      price: '500',
      imageAsset: 'assets/images/3.jpg',
      description: 'হাতে গড়া ও কারিগরি দক্ষতায় তৈরিকৃত,পরিবেশবান্ধব এবং টেকসই, প্রাকৃতিক কাদামাটি ব্যবহার।',
      sellerName: 'মিরাজ',
      sellerContact: '+880197654321',
      location: 'Barishal, Bangladesh',
      category: 'Pottery',
      videoLink: 'https://youtu.be/mudayQHB4LA?si=gCIntkpCUZGcGuit',
      history: 'মৃৎশিল্পের ইতিহাস হাজার হাজার বছর পুরনো। বাংলাদেশসহ দক্ষিণ এশিয়ার বিভিন্ন অঞ্চলে মৃৎশিল্প প্রাচীনকালে থেকে জনপ্রিয় ছিল। বিশেষ করে বাংলাদেশের বিভিন্ন গ্রামীণ এলাকায় মাটির পাত্র ও অন্যান্য বস্তু বানানোর দীর্ঘ ঐতিহ্য রয়েছে।'
          'মৃৎশিল্প শুধুমাত্র ব্যবহারিক নয়, বরং এতে ঐতিহ্য ও সংস্কৃতির ছোঁয়া রয়েছে, যা স্থানীয় কারিগরদের দক্ষতা ও সৃজনশীলতার প্রতিফলন।'
          'প্রসিদ্ধ অঞ্চল (Famous Regions): ঢাকা, রাজশাহী, বরিশাল'
          'মৃৎশিল্পের পণ্যগুলো দৈনন্দিন জীবনে ব্যবহার হয় রান্নার বাসন, জলাধার, ফুলদানি ও সজ্জার কাজে। এছাড়া এগুলো সাংস্কৃতিক অনুষ্ঠান ও গৃহসজ্জায় বিশেষ গুরুত্ব পায়। মৃৎশিল্প কারিগররা এই শিল্পকে ধরে রেখেছেন প্রজন্ম থেকে প্রজন্ম পর্যন্ত, যা আমাদের সাংস্কৃতিক ঐতিহ্যের অমূল্য অংশ।',
      relatedLink: 'https://bn.wikipedia.org/wiki/%E0%A6%AE%E0%A7%83%E0%A7%8E%E0%A6%B6%E0%A6%BF%E0%A6%B2%E0%A7%8D%E0%A6%AA_(%E0%A6%B6%E0%A6%BF%E0%A6%B2%E0%A7%8D%E0%A6%AA%E0%A6%95%E0%A6%B2%E0%A6%BE)',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Product> filteredProducts = ref.watch(filteredProductsProvider(products));
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Marketplace', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final favorites = ref.watch(favoritesProvider);
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.redAccent),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesPage())),
                    ),
                    if (favorites.isNotEmpty)
                      Positioned(
                        right: 4,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                          child: Text('${favorites.length}', style: const TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (query) => ref.read(filteredProductsProvider(products).notifier).filterProducts(query),
                decoration: InputDecoration(
                  hintText: 'Search artisan products...',
                  prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.filter_alt_outlined, color: Colors.orange),
                    onPressed: () => _showFilterOptions(context, ref),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 2));
                ref.read(filteredProductsProvider(products).notifier).resetFilters();
              },
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 55),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: isMobile ? 1.5 : 0.75,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) => ProductCard(product: filteredProducts[index]),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF252C35),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPostPage(
                  onPostAdded: (newProduct) => ref.read(filteredProductsProvider(products).notifier).addProduct(newProduct),
                ),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Filter Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(title: const Text('Price: Low to High'), onTap: () => _applySort(ref, context, 'low')),
            ListTile(title: const Text('Price: High to Low'), onTap: () => _applySort(ref, context, 'high')),
            ListTile(title: const Text('Sort by Name'), onTap: () => _applySort(ref, context, 'name')),
            ListTile(title: const Text('Reset Filters'), onTap: () => _applySort(ref, context, 'reset')),
          ],
        ),
      ),
    );
  }

  void _applySort(WidgetRef ref, BuildContext context, String type) {
    switch (type) {
      case 'low':
        ref.read(filteredProductsProvider(products).notifier).sortByPriceLowToHigh();
        break;
      case 'high':
        ref.read(filteredProductsProvider(products).notifier).sortByPriceHighToLow();
        break;
      case 'name':
        ref.read(filteredProductsProvider(products).notifier).sortByName();
        break;
      case 'reset':
        ref.read(filteredProductsProvider(products).notifier).resetFilters();
        break;
    }
    Navigator.pop(context);
  }
}

class ProductCard extends ConsumerWidget {
  final Product product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(favoritesProvider).contains(product);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDescriptionPage(product: product),
          ),
        );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                product.imageAsset,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(formatTaka(product.price), style: const TextStyle(fontSize: 14, color: Colors.teal)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.redAccent),
                        onPressed: () {
                          ref.read(favoritesProvider.notifier).toggleFavorite(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(isFav ? '${product.name} removed from favorites.' : '${product.name} added to favorites!')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          ref.read(cartProvider.notifier).addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${product.name} added to cart!')),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Product {
  final String name;
  final String price;
  final String imageAsset;
  final String description;
  final String sellerName;
  final String sellerContact;
  final String location;
  final String category;
  final String videoLink;
  final String history;
  final String relatedLink;

  Product({
    required this.name,
    required this.price,
    required this.imageAsset,
    required this.description,
    required this.sellerName,
    required this.sellerContact,
    required this.location,
    required this.category,
    required this.videoLink,
    required this.history,
    required this.relatedLink,
  });
}
