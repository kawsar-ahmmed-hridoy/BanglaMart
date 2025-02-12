import 'package:flutter/material.dart';

import 'AddPostPage.dart';

class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  List<Product> products = [
    Product(name: 'Handmade Pot', price: '\$20', imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Wooden Chair', price: '\$50', imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Bamboo Basket', price: '\$15', imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Ceramic Vase', price: '\$30', imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Cotton Scarf', price: '\$25', imageUrl: 'https://via.placeholder.com/150'),
    Product(name: 'Leather Bag', price: '\$40', imageUrl: 'https://via.placeholder.com/150'),
  ];

  List<Product> filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showFilterOptions() {
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
                title: Text('Price: ⇩ -> ⇧'),
                onTap: () {
                  setState(() {
                    filteredProducts.sort((a, b) => a.price.compareTo(b.price));
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Price: ⇧ -> ⇩'),
                onTap: () {
                  setState(() {
                    filteredProducts.sort((a, b) => b.price.compareTo(a.price));
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Reset Filters'),
                onTap: () {
                  setState(() {
                    filteredProducts = products;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
        centerTitle: true,
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
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: _showFilterOptions,
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    filterProducts(_searchController.text);
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
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
                    return ProductCard(product: filteredProducts[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPostPage(onPostAdded: (Product) {})),
            );
          },
          child: Icon(Icons.add),
          tooltip: 'Add Post',
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}