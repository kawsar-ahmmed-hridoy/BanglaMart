import 'package:flutter/material.dart';
import 'AddPostPage.dart';
import 'ProductDescriptionPage.dart';

class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  List<Product> products = [
    Product(
      name: 'Nakshi Katha',
      price: '\$20',
      imageUrl: 'https://phantomhands.in/imager/media/the-practical-magic-of-the-nakshi-kantha-a-brief-introduction/23599/9-1_515cffaa34c7b727c9423a5db08aae1f.jpg',
      description: 'A beautiful katha.',
      sellerName: 'Artisan 1',
      sellerContact: '+880123456789',
      location: 'Natore, Rajshahi, Bangladesh',
    ),
    Product(
      name: 'Jamdani Sharee',
      price: '\$50',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwrNhEl0ObNXh0IgGO7T3K5rQLVAz3U6sxwttLoTzwj5-AmGHW4lAJqV0XTU2jU8wBkiY&usqp=CAU',
      description: 'A Share.',
      sellerName: 'Artisan 2',
      sellerContact: '+880987654321',
      location: 'Tangail, Dhaka, Bangladesh',
    ),
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

  void _addNewPost(Product newProduct) {
    setState(() {
      products.add(newProduct);
      filteredProducts = products;
    });
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
              MaterialPageRoute(
                builder: (context) => AddPostPage(onPostAdded: _addNewPost),
              ),
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
  final String description;
  final String sellerName;
  final String sellerContact;
  final String location;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.sellerName,
    required this.sellerContact,
    required this.location,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}