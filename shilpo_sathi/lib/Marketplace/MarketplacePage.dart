import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Cart/CartPage.dart';
import '../Cart/CartProvider.dart';
import '../Cart/FilteredProductsProvider.dart';
import 'AddPostPage.dart';
import 'ProductDescriptionPage.dart';

class MarketplacePage extends ConsumerWidget {
  final List<Product> products = [
    Product(
      name: 'Nakshi Katha',
      price: '\$20',
      imageUrl: 'https://phantomhands.in/imager/media/the-practical-magic-of-the-nakshi-kantha-a-brief-introduction/23599/9-1_515cffaa34c7b727c9423a5db08aae1f.jpg',
      description: 'A beautiful katha.',
      sellerName: 'Artisan 1',
      sellerContact: '+880123456789',
      location: 'Natore, Rajshahi, Bangladesh',
      category: 'Handicraft',
    ),
    Product(
      name: 'Jamdani Sharee',
      price: '\$50',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwrNhEl0ObNXh0IgGO7T3K5rQLVAz3U6sxwttLoTzwj5-AmGHW4lAJqV0XTU2jU8wBkiY&usqp=CAU',
      description: 'A Share.',
      sellerName: 'Artisan 2',
      sellerContact: '+880987654321',
      location: 'Tangail, Dhaka, Bangladesh',
      category: 'Clothing',
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
        backgroundColor: Color(0xFF6ECAB8),
        title: Text('Marketplace', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(filteredProductsProvider(products).notifier).filterProducts('');
                        },
                      ),
                    ),
                    onChanged: (query) {
                      ref.read(filteredProductsProvider(products).notifier).filterProducts(query);
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    _showFilterOptions(context, ref);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                ref.read(filteredProductsProvider(products).notifier).resetFilters();
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 55),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: isMobile ? 1.5 : 0.75,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: filteredProducts[index],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF6ECAB8),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPostPage(onPostAdded: (newProduct) {
                  ref.read(filteredProductsProvider(products).notifier).addProduct(newProduct);
                }),
              ),
            );
          },
          child: Icon(Icons.add, color: Colors.white),
          tooltip: 'Add Post',
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Filter Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Divider(),
              ListTile(
                title: Text('Price: Low to High'),
                onTap: () {
                  ref.read(filteredProductsProvider(products).notifier).sortByPriceLowToHigh();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Price: High to Low'),
                onTap: () {
                  ref.read(filteredProductsProvider(products).notifier).sortByPriceHighToLow();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Sort by Name'),
                onTap: () {
                  ref.read(filteredProductsProvider(products).notifier).sortByName();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Reset Filters'),
                onTap: () {
                  ref.read(filteredProductsProvider(products).notifier).resetFilters();
                  Navigator.pop(context);
                },
              ),
              Divider(),
              Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  _selectedCategory = newValue!;
                  ref.read(filteredProductsProvider(products).notifier).filterByCategory(_selectedCategory);
                  Navigator.pop(context);
                },
                items: <String>['All', 'Handicraft', 'Clothing']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductCard extends ConsumerWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDescriptionPage(product: product),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).addToCart(product);
              },
              child: Text('Add to Cart'),
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
  final String imageUrl;
  final String description;
  final String sellerName;
  final String sellerContact;
  final String location;
  final String category;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.sellerName,
    required this.sellerContact,
    required this.location,
    required this.category,
  });
}