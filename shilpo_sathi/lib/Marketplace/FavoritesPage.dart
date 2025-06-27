import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'MarketplacePage.dart';
import 'ProductDescriptionPage.dart';

class FavoritesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProducts = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          if (favoriteProducts.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever,color: Colors.blueGrey,),
              tooltip: 'Clear All Favorites',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Favorites?'),
                    content: const Text('Are you sure you want to clear all favorites?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(favoritesProvider.notifier).clearFavorites();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
        child: Text('No favorite products yet.',
            style: TextStyle(fontSize: 16)),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product.imageAsset,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(product.price),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                tooltip: 'Remove from favorites',
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggleFavorite(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} removed from favorites.')),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDescriptionPage(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p != product).toList();
    } else {
      state = [...state, product];
    }
  }

  bool isFavorite(Product product) {
    return state.contains(product);
  }

  void clearFavorites() {
    state = [];
  }
}

