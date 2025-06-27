import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'CartProvider.dart';

String getTotalPrice(String price, int quantity) {
  final cleanPriceStr = price.replaceAll(RegExp(r'[^0-9.]'), '');
  final priceValue = double.tryParse(cleanPriceStr) ?? 0.0;
  return (priceValue * quantity).toStringAsFixed(2);
}

double parsePrice(String priceStr) {
  final cleaned = priceStr.replaceAll(RegExp(r'[^0-9.]'), '');
  return double.tryParse(cleaned) ?? 0.0;
}


class CartPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartProvider.notifier).totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      item.product.imageAsset,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.product.name),
                    subtitle: Text(
                      '\$${getTotalPrice(item.product.price, item.quantity)}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            ref.read(cartProvider.notifier).decrementQuantity(item);
                          },
                        ),
                        Text(item.quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            ref.read(cartProvider.notifier).incrementQuantity(item);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\৳${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF252C35),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF252C35),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                child: const Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
